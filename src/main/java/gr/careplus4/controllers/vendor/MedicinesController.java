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

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import gr.careplus4.ultilities.Constants.*;

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

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
        Page<Medicine> medicines = medicineService.findAll(pageable);

        int totalPages = medicines.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

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
        model.addAttribute("medicine", new Medicine());
        model.addAttribute("manufacturers", manufacturerService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("units", unitService.findAll());
        return "vendor/medicine/medicine-addOrEdit";
    }

    public String handleSaveUploadImage(MultipartFile image, String uploadDir) {
        if (image != null && !image.isEmpty()) {
            try {
                String imagePath = System.currentTimeMillis() + "-" + image.getOriginalFilename();
                Path path = Paths.get(uploadDir, imagePath);
                Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                return imagePath;
            } catch (Exception e) {
                return null;
            }
        }
        return null;
    }

    @PostMapping("/vendor/medicine/save")
    public ModelAndView handleModifyForm(ModelMap model,
                                         @Valid @ModelAttribute("medicine") MedicineModel medicineModel,
                                         BindingResult result,
                                         @RequestParam("image") MultipartFile image,
                                         @RequestParam("manufacturerName") String manufacturerName,
                                         @RequestParam("categoryName") String categoryName,
                                         @RequestParam("unitName") String unitName
    ) {
        String message = "";
        Medicine medicine = new Medicine();
        if (result.hasErrors()) {
            message = "Error adding manufacturer";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        Optional<Manufacturer> manufacturer = manufacturerService.findByName(manufacturerName);
        if (!manufacturer.isPresent()) {
            message = "Manufacturer not found";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        Optional<Category> category = categoryService.findByCategoryName(categoryName);
        if (!category.isPresent()) {
            message = "Category not found";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        Optional<Unit> unit = unitService.findByName(unitName);
        if (!unit.isPresent()) {
            message = "Unit not found";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        medicineModel.setManufacturerId(manufacturer.get().getId());
        medicineModel.setCategoryId(category.get().getId());
        medicineModel.setUnitId(unit.get().getId());


        String imagePath = handleSaveUploadImage(image, MEDICINE_UPLOAD_DIR);
        if (imagePath == null) {
            message = "Error saving image";
            model.addAttribute("message", message);
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        medicineModel.setImage(imagePath);

        BeanUtils.copyProperties(medicineModel, medicine);

        if (medicineModel.getIsEdit()) {
            medicineService.save(medicine);
            message = "Manufacturer updated successfully";
        } else {
            Medicine lastMedicine = medicineService.findTopByOrderByIdDesc();
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
        Optional<Medicine> medicine = medicineService.findById(id);
        if (!medicine.isPresent()) {
            String message = "Medicine not found";
            model.addAttribute("message", message);
            return "redirect:/vendor/medicines";
        }
        model.addAttribute("medicine", medicine.get());
        model.addAttribute("manufacturers", manufacturerService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("units", unitService.findAll());
        return "vendor/medicine/medicine-add";
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

    @GetMapping("/vendor/medicine/search/{keyword}")
    public String searchMedicine(Model model, @PathVariable("keyword") String keyword,
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

            model.addAttribute("medicines", medicines);
            model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
            model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
            return "vendor/medicine/medicines-list"; // Tên view để render danh sách thuốc
    }

    @GetMapping("/vendor/medicine/filter")
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
                                 @RequestParam(value = "importDateMin", required = false) Date importDateMin,
                                 @RequestParam(value = "importDateMax", required = false) Date importDateMax,
                                 @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                 @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize
    ) {

            // Kiem tra cac tham so dau vao co hop le khong
            if (unitCostMin != null && unitCostMax != null && unitCostMin.compareTo(unitCostMax) > 0 ) {
                model.addAttribute("message", "Unit cost min must be less than or equal to unit cost max");
                return "vendor/medicine/medicines-list";
            } else if (expiryDateMin != null && expiryDateMax != null && expiryDateMin.compareTo(expiryDateMax) > 0) {
                model.addAttribute("message", "Expiry date min must be less than or equal to expiry date max");
                return "vendor/medicine/medicines-list";
            } else if (stockQuantityMin != null && stockQuantityMax != null && stockQuantityMin.compareTo(stockQuantityMax) > 0) {
                model.addAttribute("message", "Stock quantity min must be less than or equal to stock quantity max");
                return "vendor/medicine/medicines-list";
            } else if (ratingMin != null && ratingMax != null && ratingMin.compareTo(ratingMax) > 0) {
                model.addAttribute("message", "Rating min must be less than or equal to rating max");
                return "vendor/medicine/medicines-list";
            }

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

            int totalPages = medicines.getTotalPages();
            if (totalPages > 0) {
                List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                        .boxed()
                        .collect(Collectors.toList());
                model.addAttribute("pageNumbers", pageNumbers);
            }

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

        model.addAttribute("medicines", medicines);
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

    @GetMapping("/user/medicine/search/{keyword}")
    public String searchMedicineUser(Model model, @PathVariable("keyword") String keyword,
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

            model.addAttribute("medicines", medicines);
            model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
            model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
            return "user/medicine/medicines-list"; // Tên view để render danh sách thuốc
    }

    @GetMapping("/user/medicine/filter")
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
        model.addAttribute("medicines", filteredMedicines.getContent());
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", filteredMedicines.getTotalPages());
        model.addAttribute("totalItems", filteredMedicines.getTotalElements());
        model.addAttribute("pageSize", pageSize);

        // Trả về trang hiển thị danh sách thuốc
        return "user/medicine/medicines-list";
    }
}
