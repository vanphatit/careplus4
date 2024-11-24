package gr.careplus4.controllers.vendor;

import gr.careplus4.entities.*;
import gr.careplus4.models.*;
import gr.careplus4.services.impl.*;
import jakarta.validation.Valid;
import lombok.Data;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import gr.careplus4.ultilities.Constants.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import static gr.careplus4.ultilities.Constants.MEDICINE_UPLOAD_DIR;

@Controller
@RequestMapping
public class MedicinesController {

    @Autowired
    private MedicineServicesImpl medicineService;

    @Autowired
    private ManufacturerServicesImpl manufacturerService;

    @Autowired
    private CategoryServiceImpl categoryService;

    @Autowired
    private UnitServicesImpl unitService;

    @Autowired
    private FileSystemStorageServiceImpl storageService;

    public MedicinesController(MedicineServicesImpl medicineService,
                               ManufacturerServicesImpl manufacturerService,
                               CategoryServiceImpl categoryService,
                               UnitServicesImpl unitService,
                               FileSystemStorageServiceImpl storageService) {
        this.medicineService = medicineService;
        this.manufacturerService = manufacturerService;
        this.categoryService = categoryService;
        this.unitService = unitService;
        this.storageService = storageService;
    }

    @GetMapping("/vendor/medicines")
    public String getListMedicines(Model model,
                                   @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                   @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize) {
        // Đảm bảo currentPage >= 1
        currentPage = Math.max(currentPage, 1);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id").ascending());
        Page<Medicine> medicines = medicineService.findAll(pageable);

        int totalPages = medicines.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("manufacturers", manufacturerService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("units", unitService.findAll());

        model.addAttribute("medicines", medicines);
        model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
        model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
        return "vendor/medicine/medicines-list"; // Tên view để render danh sách thuốc
    }

    @GetMapping("/vendor/medicine/{id}")
    public String getMedicineById(Model model, @PathVariable("id") String id) {
        Optional<Medicine> medicine = medicineService.findById(id);

        if (!medicine.isPresent()) {
            String message = "Medicine not found";
            model.addAttribute("message", message);
            return "redirect:/vendor/medicines";
        }
        System.out.println(medicine.get());
        String message = "Medicine found";
        model.addAttribute("medicine", medicine.get());
        model.addAttribute("message", message);
        return "vendor/medicine/medicine-detail";
    }

    @GetMapping("/vendor/medicine/add")
    public String addMedicine(Model model
                              ) {
        MedicineModel medicineModel = new MedicineModel();
        medicineModel.setIsEdit(false);
        model.addAttribute("medicine", medicineModel);
        model.addAttribute("manufacturers", manufacturerService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("units", unitService.findAll());
        return "vendor/medicine/medicine-addOrEdit";
    }

    public String handleSaveUploadImage(MultipartFile image, String uploadDir) {
        if (image != null && !image.isEmpty()) {
            try {
                // Kiểm tra và tạo thư mục nếu chưa tồn tại
                Path uploadPath = Paths.get(uploadDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                // Xử lý tên file để tránh ký tự không hợp lệ
                String sanitizedFileName = System.currentTimeMillis() + "-" + image.getOriginalFilename().replaceAll("[^a-zA-Z0-9.\\-_]", "_");

                // Đường dẫn đầy đủ của file
                Path path = uploadPath.resolve(sanitizedFileName);

                // Lưu file
                Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

                // Trả về tên file (hoặc đường dẫn)
                return sanitizedFileName;
            } catch (Exception e) {
                // Log lỗi để dễ dàng gỡ lỗi
                e.printStackTrace();
                return null;
            }
        }
        return null;
    }

    @PostMapping("/vendor/medicine/save")
    public ModelAndView handleModifyForm(ModelMap model,
                                         @Valid @ModelAttribute("medicine") MedicineModel medicineModel,
                                         @RequestParam("image") MultipartFile image,
                                         @RequestParam("manufacturerId") String manufacturerId,
                                         @RequestParam("categoryId") String categoryId,
                                         @RequestParam("unitId") String unitId
    ) {

        System.out.println(manufacturerId);
        System.out.println(categoryId);
        System.out.println(unitId);

        String message = "";
        Medicine medicine = new Medicine();
        Optional<Manufacturer> manufacturer = manufacturerService.findById(manufacturerId);

        System.out.println(manufacturer);

        if (!manufacturer.isPresent()) {
            message = "Manufacturer not found";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        Optional<Category> category = categoryService.findById(categoryId);
        if (!category.isPresent()) {
            message = "Category not found";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        Optional<Unit> unit = unitService.findById(unitId);
        if (!unit.isPresent()) {
            message = "Unit not found";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        if (medicineModel.getExpiryDate() != null && medicineModel.getExpiryDate().before(new Date())) {
            message = "Expiry date must be in the future";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        if (medicineModel.getStockQuantity() < 0) {
            message = "Stock quantity must be greater than or equal to 0";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        if (medicineModel.getUnitCost().compareTo(BigDecimal.ZERO) < 0) {
            message = "Unit cost must be greater than or equal to 0";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        if (medicineModel.getIsEdit())
            if (medicineModel.getRating().compareTo(BigDecimal.ZERO) < 0 && medicineModel.getRating().compareTo(BigDecimal.valueOf(5)) > 0) {
                message = "Rating must be greater than or equal to 0 and less than or equal to 5";
                model.addAttribute("message", message);
                return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
            }

        // Xử lý upload file (nếu có)
        if (medicineModel.getImage() != null && !medicineModel.getImage().isEmpty()) {
            String imagePath = handleSaveUploadImage(medicineModel.getImage(), MEDICINE_UPLOAD_DIR);
            if (imagePath != null) {
                medicine.setImage(imagePath); // Lưu đường dẫn file vào Entity
            }
        } else {
            // Nếu không upload ảnh mới, giữ nguyên ảnh cũ (nếu chỉnh sửa)
            if (medicine.getId() != null) {
                Optional<Medicine> existingMedicine = medicineService.findById(medicine.getId());
                existingMedicine.ifPresent(existing -> medicine.setImage(existing.getImage()));
            }
        }

        BeanUtils.copyProperties(medicineModel, medicine);

        medicine.setImportDate(new Date());
        medicine.setManufacturer(manufacturer.get());
        medicine.setCategory(category.get());
        medicine.setUnit(unit.get());

        System.out.println(medicine);

        if (medicineModel.getIsEdit()) {
            medicineService.save(medicine);
            message = "Manufacturer updated successfully";
        } else {
            Medicine lastMedicine = medicineService.findTopByOrderByIdDesc();
            medicine.setRating(new BigDecimal(0));
            String previousMedicineId = (lastMedicine != null) ? lastMedicine.getId() : "MED0000";
            medicine.setId(medicineService.generateMedicineId(previousMedicineId));
            medicineService.save(medicine);
            message = "Manufacturer added successfully";
        }
        model.addAttribute("message", message);

        return new ModelAndView("redirect:/vendor/medicines", model);
    }

    @GetMapping("/vendor/medicine/edit/{id}")
    public String editMedicine(Model model, @PathVariable("id") String id) {
        Optional<Medicine> medicineO = medicineService.findById(id);
        if (!medicineO.isPresent()) {
            String message = "Medicine not found";
            model.addAttribute("message", message);
            return "redirect:/vendor/medicines";
        }

        Medicine medicine = medicineO.get();

        MedicineModel medicineModel = new MedicineModel();

        BeanUtils.copyProperties(medicine, medicineModel);

        if (medicine.getCategory() != null) {
            medicineModel.setCategoryId(medicine.getCategory().getId());
        }
        if (medicine.getManufacturer() != null) {
            medicineModel.setManufacturerId(medicine.getManufacturer().getId());
        }
        if (medicine.getUnit() != null) {
            medicineModel.setUnitId(medicine.getUnit().getId());
        }
        if (medicine.getImage() != null) {
            medicineModel.setImageUrl(medicine.getImage());
        }

        model.addAttribute("medicine", medicineModel);
        model.addAttribute("manufacturers", manufacturerService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("units", unitService.findAll());
        return "vendor/medicine/medicine-addOrEdit";
    }

    @GetMapping("/vendor/medicine/delete/{id}")
    public ModelAndView deleteMedicine(ModelMap model, @PathVariable("id") String id) {
        Optional<Medicine> medicine = medicineService.findById(id);
        if (medicine.isPresent()) {
            medicineService.deleteById(id);
            model.addAttribute("message", "Medicine deleted successfully");
            return new ModelAndView("redirect:/vendor/medicines", model);
        }
        model.addAttribute("message", "Medicine not found");
        return new ModelAndView("redirect:/vendor/medicines", model);
    }

    @PostMapping("/vendor/medicine/search")
    public String searchMedicine(Model model, @RequestParam("keyword") String keyword,
                                    @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                    @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize) {
            // Đảm bảo currentPage >= 1
            currentPage = Math.max(currentPage, 1);

            Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
            Page<Medicine> medicines = medicineService.searchMedicineByKeyword(keyword, pageable);

            int totalPages = medicines.getTotalPages();
            if (totalPages > 0) {
                List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                        .boxed()
                        .collect(Collectors.toList());
                model.addAttribute("pageNumbers", pageNumbers);
            }

            model.addAttribute("manufacturers", manufacturerService.findAll());
            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("units", unitService.findAll());

            model.addAttribute("medicines", medicines);
            model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
            model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
            model.addAttribute("keyword", keyword);         // Để view biết từ khóa tìm kiếm
            return "vendor/medicine/medicines-list"; // Tên view để render danh sách thuốc
    }

    @PostMapping("/vendor/medicine/filter")
    public String filterMedicine(Model model,
                                 @RequestParam(value = "manufacturerName", required = false) String manufacturerName,
                                 @RequestParam(value = "categoryName", required = false) String categoryName,
                                 @RequestParam(value = "unitName", required = false) String unitName,
                                 @RequestParam(value = "unitCostMin", required = false) BigDecimal unitCostMin,
                                 @RequestParam(value = "unitCostMax", required = false) BigDecimal unitCostMax,
                                 @RequestParam(value = "expiryDateMin", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date expiryDateMin,
                                 @RequestParam(value = "expiryDateMax", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date expiryDateMax,
                                 @RequestParam(value = "stockQuantityMin", required = false) Integer stockQuantityMin,
                                 @RequestParam(value = "stockQuantityMax", required = false) Integer stockQuantityMax,
                                 @RequestParam(value = "ratingMin", required = false) BigDecimal ratingMin,
                                 @RequestParam(value = "ratingMax", required = false) BigDecimal ratingMax,
                                 @RequestParam(value = "importDateMin", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date importDateMin,
                                 @RequestParam(value = "importDateMax", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date importDateMax,
                                 @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                 @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize
    ) {

            model.addAttribute("manufacturers", manufacturerService.findAll());
            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("units", unitService.findAll());

            if (manufacturerName == "") manufacturerName = null;
            if (categoryName == "") categoryName = null;
            if (unitName == "") unitName = null;

            System.out.println(manufacturerName);
            System.out.println(categoryName);
            System.out.println(unitName);
            System.out.println(unitCostMin);
            System.out.println(unitCostMax);
            System.out.println(expiryDateMin);
            System.out.println(expiryDateMax);
            System.out.println(stockQuantityMin);
            System.out.println(stockQuantityMax);
            System.out.println(ratingMin);
            System.out.println(ratingMax);
            System.out.println(importDateMin);
            System.out.println(importDateMax);

            // Đảm bảo currentPage >= 1
            currentPage = Math.max(currentPage, 1);

            Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
            Page<Medicine> medicines = medicineService.filterMedicineFlexible(
                    manufacturerName, categoryName, unitName,
                    unitCostMin, unitCostMax,
                    expiryDateMin, expiryDateMax,
                    stockQuantityMin, stockQuantityMax,
                    ratingMin, ratingMax,
                    importDateMin, importDateMax,
                    pageable
            );

            for (Medicine medicine : medicines) {
                System.out.println(medicine);
            }

            int totalPages = medicines.getTotalPages();
            if (totalPages > 0) {
                List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                        .boxed()
                        .collect(Collectors.toList());
                model.addAttribute("pageNumbers", pageNumbers);
            }

            model.addAttribute("manufacturerName", manufacturerName);
            model.addAttribute("categoryName", categoryName);
            model.addAttribute("unitName", unitName);
            model.addAttribute("unitCostMin", unitCostMin);
            model.addAttribute("unitCostMax", unitCostMax);
            model.addAttribute("expiryDateMin", expiryDateMin);
            model.addAttribute("expiryDateMax", expiryDateMax);
            model.addAttribute("stockQuantityMin", stockQuantityMin);
            model.addAttribute("stockQuantityMax", stockQuantityMax);
            model.addAttribute("ratingMin", ratingMin);
            model.addAttribute("ratingMax", ratingMax);
            model.addAttribute("importDateMin", importDateMin);
            model.addAttribute("importDateMax", importDateMax);
            model.addAttribute("medicines", medicines);
            model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
            model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang

            return "vendor/medicine/medicines-list"; // Tên view để render danh sách thuốc
    }

    @GetMapping("/vendor/medicine/exist/{name}&{expiryDate}&{manufacturerName}&{importDate}")
    public String medicineIsExist(Model model, @PathVariable("name") String name, @PathVariable("expiryDate") Date expiryDate, @PathVariable("manufacturerName") String manufacturerName, @PathVariable("importDate") Date importDate) {
        Boolean check = medicineService.medicineIsExist(name, expiryDate, manufacturerName, importDate);
        if (check) {
            model.addAttribute("message", "Medicine exists");
        } else {
            model.addAttribute("message", "Medicine does not exist");
        }
        return "vendor/medicine/medicines-list";
    }

    @GetMapping("/user/medicines")
    public String getListMedicinesUser(Model model,
                                   @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                   @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize) {
        // Đảm bảo currentPage >= 1
        currentPage = Math.max(currentPage, 1);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
        Page<MedicineForUserModel> medicines = medicineService.getMedicinesForUser(pageable);

        int totalPages = medicines.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("manufacturers", manufacturerService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("units", unitService.findAll());

        model.addAttribute("medicines", medicines.getContent());
        model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
        model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
        return "user/medicine/medicines-list"; // Tên view để render danh sách thuốc
    }

    @GetMapping("/user/medicine/{id}")
    public String getMedicineByIdUser(Model model, @PathVariable("id") String id) {
        Optional<MedicineForUserModel> medicine = medicineService.findMedicineByIdForUser(id);

        if (!medicine.isPresent()) {
            String message = "Medicine not found";
            model.addAttribute("message", message);
            return "redirect:/user/medicines";
        }
        String message = "Medicine found";
        model.addAttribute("medicine", medicine.get());
        model.addAttribute("message", message);
        return "user/medicine/medicine-detail";
    }

    @PostMapping("/user/medicine/search")
    public String searchMedicineUser(Model model, @RequestParam("keyword") String keyword,
                                    @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                    @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize) {
            // Đảm bảo currentPage >= 1
            currentPage = Math.max(currentPage, 1);

            Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
            Page<MedicineForUserModel> medicines = medicineService.searchMedicineByKeywordForUser(keyword, pageable);

            int totalPages = medicines.getTotalPages();
            if (totalPages > 0) {
                List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                        .boxed()
                        .collect(Collectors.toList());
                model.addAttribute("pageNumbers", pageNumbers);
            }

            model.addAttribute("manufacturers", manufacturerService.findAll());
            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("units", unitService.findAll());
            model.addAttribute("medicines", medicines.getContent());
            model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
            model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
            return "user/medicine/medicines-list"; // Tên view để render danh sách thuốc
    }

    @PostMapping("/user/medicine/filter")
    public String filterMedicineUser(Model model,
                                     @RequestParam(value = "manufacturerName", required = false) String manufacturerName,
                                     @RequestParam(value = "categoryName", required = false) String categoryName,
                                     @RequestParam(value = "unitName", required = false) String unitName,
                                     @RequestParam(value = "unitCostMin", required = false) BigDecimal unitCostMin,
                                     @RequestParam(value = "unitCostMax", required = false) BigDecimal unitCostMax,
                                     @RequestParam(value = "expiryDateMin", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date expiryDateMin,
                                     @RequestParam(value = "expiryDateMax", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date expiryDateMax,
                                     @RequestParam(value = "stockQuantityMin", required = false) Integer stockQuantityMin,
                                     @RequestParam(value = "stockQuantityMax", required = false) Integer stockQuantityMax,
                                     @RequestParam(value = "ratingMin", required = false) BigDecimal ratingMin,
                                     @RequestParam(value = "ratingMax", required = false) BigDecimal ratingMax,
                                     @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                     @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize) {

        // Kiểm tra các tham số đầu vào
        if (unitCostMin != null && unitCostMax != null && unitCostMin.compareTo(unitCostMax) > 0) {
            model.addAttribute("message", "Unit cost min must be less than or equal to unit cost max");
            return "user/medicine/medicines-list";
        }
        if (expiryDateMin != null && expiryDateMax != null && expiryDateMin.compareTo(expiryDateMax) > 0) {
            model.addAttribute("message", "Expiry date min must be less than or equal to expiry date max");
            return "user/medicine/medicines-list";
        }
        if (stockQuantityMin != null && stockQuantityMax != null && stockQuantityMin.compareTo(stockQuantityMax) > 0) {
            model.addAttribute("message", "Stock quantity min must be less than or equal to stock quantity max");
            return "user/medicine/medicines-list";
        }
        if (ratingMin != null && ratingMax != null && ratingMin.compareTo(ratingMax) > 0) {
            model.addAttribute("message", "Rating min must be less than or equal to rating max");
            return "user/medicine/medicines-list";
        }

        // Gọi service để lấy danh sách thuốc đã lọc
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize);
        Page<MedicineForUserModel> filteredMedicines = medicineService.filterMedicineFlexibleForUser(
                manufacturerName, categoryName, unitName, unitCostMin, unitCostMax,
                expiryDateMin, expiryDateMax, stockQuantityMin, stockQuantityMax,
                ratingMin, ratingMax, pageable
        );

        // Cập nhật model để hiển thị dữ liệu
        model.addAttribute("manufacturers", manufacturerService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("units", unitService.findAll());
        model.addAttribute("medicines", filteredMedicines.getContent());
        model.addAttribute("manufacturerName", manufacturerName);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("unitName", unitName);
        model.addAttribute("unitCostMin", unitCostMin);
        model.addAttribute("unitCostMax", unitCostMax);
        model.addAttribute("expiryDateMin", expiryDateMin);
        model.addAttribute("expiryDateMax", expiryDateMax);
        model.addAttribute("stockQuantityMin", stockQuantityMin);
        model.addAttribute("stockQuantityMax", stockQuantityMax);
        model.addAttribute("ratingMin", ratingMin);
        model.addAttribute("ratingMax", ratingMax);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", filteredMedicines.getTotalPages());
        model.addAttribute("totalItems", filteredMedicines.getTotalElements());
        model.addAttribute("pageSize", pageSize);

        // Trả về trang hiển thị danh sách thuốc
        return "user/medicine/medicines-list";
    }
}
