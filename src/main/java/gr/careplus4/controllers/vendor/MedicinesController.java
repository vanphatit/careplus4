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
import java.util.*;
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

    @Autowired
    private ReviewServiceImpl reviewService;

    @Autowired
    private ReviewDetailServiceImpl reviewDetailService;

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

    public MedicineModel processMedicine(MedicineModel model) {
        // Phân tích mô tả và thêm các phần vào model
        Map<String, Object> descriptionParts = medicineService.parseDescription(model.getDescription(), model.getName());

        // Kiểm tra và gán từng phần
        model.setDescription(descriptionParts.get("Mô tả sản phẩm") != null ? descriptionParts.get("Mô tả sản phẩm").toString() : "");
        model.setIngredients(descriptionParts.get("Thành phần") != null ? (List<Map<String, String>>) descriptionParts.get("Thành phần") : new ArrayList<>());
        model.setUsage(descriptionParts.get("Công dụng") != null ? descriptionParts.get("Công dụng").toString() : "");
        model.setDirections(descriptionParts.get("Cách dùng") != null ? descriptionParts.get("Cách dùng").toString() : "");
        model.setSideEffects(descriptionParts.get("Tác dụng phụ") != null ? descriptionParts.get("Tác dụng phụ").toString() : "");
        model.setPrecautions(descriptionParts.get("Lưu ý") != null ? descriptionParts.get("Lưu ý").toString() : "");
        model.setStorage(descriptionParts.get("Bảo quản") != null ? descriptionParts.get("Bảo quản").toString() : "");

        return model;
    }


    public MedicineForUserModel processMedicine(MedicineForUserModel model) {
        // Phân tích mô tả và thêm các phần vào model
        Map<String, Object> descriptionParts = medicineService.parseDescription(model.getDescription(), model.getName());

        // Kiểm tra và gán từng phần
        model.setDescription(descriptionParts.get("Mô tả sản phẩm") != null ? descriptionParts.get("Mô tả sản phẩm").toString() : "");
        model.setIngredients(descriptionParts.get("Thành phần") != null ? (List<Map<String, String>>) descriptionParts.get("Thành phần") : new ArrayList<>());
        model.setUsage(descriptionParts.get("Công dụng") != null ? descriptionParts.get("Công dụng").toString() : "");
        model.setDirections(descriptionParts.get("Cách dùng") != null ? descriptionParts.get("Cách dùng").toString() : "");
        model.setSideEffects(descriptionParts.get("Tác dụng phụ") != null ? descriptionParts.get("Tác dụng phụ").toString() : "");
        model.setPrecautions(descriptionParts.get("Lưu ý") != null ? descriptionParts.get("Lưu ý").toString() : "");
        model.setStorage(descriptionParts.get("Bảo quản") != null ? descriptionParts.get("Bảo quản").toString() : "");

        return model;
    }

    @GetMapping("/vendor/medicines")
    public String getListMedicines(Model model,
                                   @RequestParam(value = "message", required = false) String message,
                                   @RequestParam(value = "categoryId", required = false) String categoryId,
                                   @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                   @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize) {
        // Đảm bảo currentPage >= 1
        currentPage = Math.max(currentPage, 1);

        Page<Medicine> medicines = null;

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id").ascending());
        if (categoryId != null) {
            medicines = medicineService.searchMedicineByKeyword(categoryId, pageable);
        } else  medicines = medicineService.findAll(pageable);

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

        model.addAttribute("message", message);
        model.addAttribute("medicines", medicines);
        model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
        model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
        return "vendor/medicine/medicines-list"; // Tên view để render danh sách thuốc
    }

    @GetMapping("/vendor/medicine/{id}")
    public String getMedicineById(Model model, @PathVariable("id") String id,
                                  @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                  @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize
    ) {
        Optional<Medicine> medicine = medicineService.findById(id);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id").ascending());
        Page<ReviewForUserModel> reviews = reviewDetailService.findReviewForUserModelByMedicineId(id, pageable);

        MedicineModel medicineModel = new MedicineModel();
        medicineModel.setName(medicine.get().getName());
        medicineModel.setDescription(medicine.get().getDescription());
        medicineModel = processMedicine(medicineModel);

        int totalPages = reviews.getTotalPages();

        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("reviews", reviews);
        if (!medicine.isPresent()) {
            String message = "Không tìm thấy thuốc";
            model.addAttribute("message", message);
            return "redirect:/vendor/medicines";
        }
        String message = "Đã tìm thấy thuốc " + medicine.get().getName();
        model.addAttribute("medicine", medicine.get());
        model.addAttribute("message", message);
        model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
        model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
        model.addAttribute("description", medicineModel.getDescription());
        model.addAttribute("ingredients", medicineModel.getIngredients());
        model.addAttribute("usage", medicineModel.getUsage());
        model.addAttribute("directions", medicineModel.getDirections());
        model.addAttribute("sideEffects", medicineModel.getSideEffects());
        model.addAttribute("precautions", medicineModel.getPrecautions());
        model.addAttribute("storage", medicineModel.getStorage());
        return "vendor/medicine/medicine-detail";
    }

    @GetMapping("/vendor/medicine/add")
    public String addMedicine(Model model,
                              @RequestParam(value = "importId", required = false) String importId
                              ) {
        MedicineModel medicineModel = new MedicineModel();
        medicineModel.setIsEdit(false);
        model.addAttribute("importId", importId);
        model.addAttribute("CURRENTDATE", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        model.addAttribute("medicine", medicineModel);
        model.addAttribute("manufacturers", manufacturerService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("units", unitService.findAll());
        return "vendor/medicine/medicine-addOrEdit";
    }

    private String generateFileName(String medicineName, String fileExtension) {
        // Format: <medicine_name>_yyyyMMdd_HHmmss.<extension>
        String timestamp = new java.text.SimpleDateFormat("yyyyMMdd_hhmmss").format(new java.util.Date());
        String sanitizedMedicineName = medicineName.replaceAll("[^a-zA-Z0-9]", "_"); // Loại bỏ ký tự đặc biệt
        return sanitizedMedicineName + "_" + timestamp + "." + fileExtension.toLowerCase();
    }

    public String handleSaveUploadImage(MultipartFile image, String uploadDir, String medicineName) {
        if (image != null && !image.isEmpty()) {
            try {
                // Kiểm tra và tạo thư mục nếu chưa tồn tại
                Path uploadPath = Paths.get(uploadDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                // Xử lý tên file để tránh ký tự không hợp lệ
                String sanitizedFileName = generateFileName(medicineName, "png");

                // Đường dẫn đầy đủ của file
                Path path = uploadPath.resolve(sanitizedFileName);

                // Lưu file
                Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

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
                                         @RequestParam("unitId") String unitId,
                                         @RequestParam(value = "importId", required = false) String importId,
                                         RedirectAttributes redirectAttributes
    ) {
        String message = "";
        Medicine medicine = new Medicine();
        Optional<Manufacturer> manufacturer = manufacturerService.findById(manufacturerId);

        model.addAttribute("manufacturers", manufacturerService.findAll());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("units", unitService.findAll());

        model.addAttribute("CURRENTDATE", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));

        if (!manufacturer.isPresent()) {
            redirectAttributes.addFlashAttribute("message", "Nhà sản xuất không tồn tại");
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        Optional<Category> category = categoryService.findById(categoryId);
        if (!category.isPresent()) {
            redirectAttributes.addFlashAttribute("message", "Danh mục không tồn tại");
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        Optional<Unit> unit = unitService.findById(unitId);
        if (!unit.isPresent()) {
            redirectAttributes.addFlashAttribute("message", "Đơn vị không tồn tại");
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        if (medicineModel.getExpiryDate() != null && medicineModel.getExpiryDate().before(new Date())) {
            redirectAttributes.addFlashAttribute("message", "Ngày hết hạn phải sau ngày hiện tại");
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        if (medicineModel.getStockQuantity() < 0) {
            redirectAttributes.addFlashAttribute("message", "Số lượng tồn kho phải lớn hơn hoặc bằng 0");
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        if (medicineModel.getIsEdit()) {
            if (medicineModel.getRating().compareTo(BigDecimal.ZERO) < 0 && medicineModel.getRating().compareTo(BigDecimal.valueOf(5)) > 0) {
                redirectAttributes.addFlashAttribute("message", "Đánh giá phải nằm trong khoảng từ 0 đến 5");
                return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
            }
        }

        // Nếu ko là edit thì kiểm tra xem anh có rỗng không
        if (!medicineModel.getIsEdit() && (image == null || image.isEmpty())) {
            redirectAttributes.addFlashAttribute("message", "Ảnh không được để trống");
            return new ModelAndView("vendor/medicine/medicine-addOrEdit", model);
        }

        // Xử lý upload file (nếu có)
        if (medicineModel.getImage() != null && !medicineModel.getImage().isEmpty()) {
            String imagePath = handleSaveUploadImage(medicineModel.getImage(), MEDICINE_UPLOAD_DIR, medicineModel.getName());
            if (imagePath != null) {
                // Lưu đường dẫn ảnh mới vào Entity
                String oldImagePath = null;
                if (medicineModel.getId() != null) {
                    // Lấy ảnh cũ trước khi ghi đè
                    Optional<Medicine> existingMedicine = medicineService.findById(medicineModel.getId());
                    if (existingMedicine.isPresent() && existingMedicine.get().getImage() != null) {
                        oldImagePath = MEDICINE_UPLOAD_DIR + "/" + existingMedicine.get().getImage();
                    }
                }

                // Set đường dẫn ảnh mới vào Entity
                medicine.setImage(imagePath);

                // Sau khi lưu đường dẫn ảnh mới, xóa ảnh cũ (nếu có)
                if (oldImagePath != null) {
                    File oldImageFile = new File(oldImagePath);
                    if (oldImageFile.exists() && oldImageFile.isFile()) {
                        boolean deleted = oldImageFile.delete();
                    }
                }
            }
        } else {
            // Nếu không upload ảnh mới, giữ nguyên ảnh cũ (nếu chỉnh sửa)
            if (medicine.getId() != null) {
                Optional<Medicine> existingMedicine = medicineService.findById(medicine.getId());
                if (existingMedicine.isPresent() && existingMedicine.get().getImage() != null) {
                    medicine.setImage(existingMedicine.get().getImage()); // Giữ lại ảnh cũ
                } else {
                    medicine.setImage(null); // Nếu không có ảnh cũ, đặt null
                }
            } else {
                // Trường hợp thêm mới mà không upload ảnh, đặt null
                medicine.setImage(null);
            }
        }

        if (medicineModel.getIsEdit()){
            Medicine oldMedicine = medicineService.findById(medicineModel.getId()).get();
            medicineModel.setRating(oldMedicine.getRating());
        }

        BeanUtils.copyProperties(medicineModel, medicine);

        medicine.setImportDate(new Date());
        medicine.setManufacturer(manufacturer.get());
        medicine.setCategory(category.get());
        medicine.setUnit(unit.get());

        if (medicineModel.getIsEdit()) {
            medicineService.save(medicine);
            message = "Thông tin thuốc đã được cập nhật";
            model.addAttribute("message", message);
            return new ModelAndView("redirect:/vendor/medicines", model);
        } else {
            Medicine lastMedicine = medicineService.findTopByOrderByIdDesc();
            medicine.setRating(new BigDecimal(0));
            String previousMedicineId = (lastMedicine != null) ? lastMedicine.getId() : "MED0000";
            medicine.setId(medicineService.generateMedicineId(previousMedicineId));
            medicineService.save(medicine);
            ModelMap modelMap = new ModelMap();
            modelMap.addAttribute("medicineId", medicine.getId());
            modelMap.addAttribute("importId", importId);
            return new ModelAndView("vendor/import/import-detail-add", modelMap);
        }
    }

    @GetMapping("/vendor/medicine/edit/{id}")
    public String editMedicine(Model model, @PathVariable("id") String id) {
        Optional<Medicine> medicineO = medicineService.findById(id);
        if (!medicineO.isPresent()) {
            String message = "Không tìm thấy thuốc";
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
        model.addAttribute("CURRENTDATE", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
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
            model.addAttribute("message", "Thuốc đã được xóa");
            return new ModelAndView("redirect:/vendor/medicines", model);
        }
        model.addAttribute("message", "Không tìm thấy thuốc");
        return new ModelAndView("redirect:/vendor/medicines", model);
    }

    @PostMapping("/vendor/medicine/search")
    public String searchMedicine(Model model, @RequestParam("keyword") String keyword,
                                    @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                    @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize,
                                    RedirectAttributes redirectAttributes) {
            // Đảm bảo currentPage >= 1
            currentPage = Math.max(currentPage, 1);

            Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
            Page<Medicine> medicines = medicineService.searchMedicineByKeyword(keyword, pageable);

            if (medicines.isEmpty()) {
                redirectAttributes.addFlashAttribute("message", "Không tìm thấy thuốc");
                return "redirect:/vendor/medicines";
            }

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
                                 @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize,
                                 RedirectAttributes redirectAttributes
    ) {

            model.addAttribute("manufacturers", manufacturerService.findAll());
            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("units", unitService.findAll());

            if (manufacturerName == "") manufacturerName = null;
            if (categoryName == "") categoryName = null;
            if (unitName == "") unitName = null;

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

            if (medicines.isEmpty()) {
                redirectAttributes.addFlashAttribute("message", "Không tìm thấy thuốc");
                return "redirect:/vendor/medicines";
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
    public String medicineIsExist(Model model, @PathVariable("name") String name, @PathVariable("expiryDate") Date expiryDate, @PathVariable("manufacturerName") String manufacturerName, @PathVariable("importDate") Date importDate, RedirectAttributes redirectAttributes) {
        Boolean check = medicineService.medicineIsExist(name, expiryDate, manufacturerName, importDate);
        if (check) {
            model.addAttribute("message", "Thuốc " + name + " đã tồn tại");
        } else {
           redirectAttributes.addFlashAttribute("message", "Medicine not found");
        }
        return "vendor/medicine/medicines-list";
    }

    @GetMapping("/user/medicines")
    public String getListMedicinesUser(Model model,
                                   @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                   @RequestParam(value = "size", required = false, defaultValue = "12") int pageSize,
                                   @RequestParam(value = "categoryId", required = false) String categoryId
                                       ) {
        // Đảm bảo currentPage >= 1
        currentPage = Math.max(currentPage, 1);
        Page<MedicineForUserModel> medicines = null;
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
        if (categoryId != null) {
            String categoryName = categoryService.findById(categoryId).get().getName();
            medicines = medicineService.getMedicineForUserByCategoryName(categoryName, pageable);
        } else{
            medicines = medicineService.getMedicinesForUser(pageable);
        }

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

        List<MedicineForUserModel> list = medicines.getContent();

        model.addAttribute("medicines", list);
        model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
        model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
        return "user/medicine/medicines-list"; // Tên view để render danh sách thuốc
    }

    private List<List<MedicineForUserModel>> splitList(Set<MedicineForUserModel> set, int size) {
        List<MedicineForUserModel> list = new ArrayList<>(set); // Chuyển Set thành List
        List<List<MedicineForUserModel>> chunks = new ArrayList<>();
        for (int i = 0; i < list.size(); i += size) {
            chunks.add(list.subList(i, Math.min(i + size, list.size())));
        }
        return chunks;
    }

    @GetMapping("/user/medicine/{id}")
    public String getMedicineByIdUser(Model model,
                                      @PathVariable("id") String id,
                                      @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                      @RequestParam(value = "productPage", required = false, defaultValue = "1") int productPage,
                                      @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize,
                                      @RequestParam(value = "productSize", required = false, defaultValue = "5") int productPageSize,
                                        RedirectAttributes redirectAttributes
                                      ) {
        Optional<MedicineForUserModel> medicine = medicineService.findMedicineByIdForUser(id);


        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id").ascending());
        Pageable productPageable = PageRequest.of(productPage - 1, productPageSize, Sort.by("id").ascending());
        Page<ReviewForUserModel> reviews = reviewDetailService.findReviewForUserModelByMedicineId(id, pageable);
        Page<MedicineForUserModel> medicines_relative_Man = medicineService.searchMedicineByKeywordForUser(medicine.get().getManufacturerName(), productPageable);
        Page<MedicineForUserModel> medicines_relative_Cat = medicineService.searchMedicineByKeywordForUser(medicine.get().getCategoryName(), productPageable);
        Page<MedicineForUserModel> medicines_relative = medicineService.searchMedicineByKeywordForUser(medicine.get().getDosage(), productPageable);

        MedicineForUserModel medicineModel = new MedicineForUserModel();
        medicineModel.setName(medicine.get().getName());
        medicineModel.setDescription(medicine.get().getDescription());
        medicineModel = processMedicine(medicineModel);

        if (!medicine.isPresent()) {
            redirectAttributes.addFlashAttribute("message", "Không tìm thấy thuốc");
            return "redirect:/user/medicines";
        }


        // Chuyển các trang thành các danh sách
        List<MedicineForUserModel> list_Man = medicines_relative_Man.getContent();
        List<MedicineForUserModel> list_Cat = medicines_relative_Cat.getContent();
        List<MedicineForUserModel> list_Name = medicines_relative.getContent();

        // Kết hợp các danh sách vào một list duy nhất
        List<MedicineForUserModel> list = new ArrayList<>();
        list.addAll(list_Man);
        list.addAll(list_Cat);
        list.addAll(list_Name);

        Set<MedicineForUserModel> uniqueList = new HashSet<>(list);

        // Chia nhóm sản phẩm (5 sản phẩm mỗi nhóm)
        List<List<MedicineForUserModel>> groupedProducts = splitList(uniqueList, 2);

        String message = "Đã tìm thấy thuốc";
        model.addAttribute("reviews", reviews);
        model.addAttribute("medicine", medicine.get());
        model.addAttribute("message", message);
        model.addAttribute("description", medicineModel.getDescription());
        model.addAttribute("ingredients", medicineModel.getIngredients());
        model.addAttribute("usage", medicineModel.getUsage());
        model.addAttribute("directions", medicineModel.getDirections());
        model.addAttribute("sideEffects", medicineModel.getSideEffects());
        model.addAttribute("precautions", medicineModel.getPrecautions());
        model.addAttribute("storage", medicineModel.getStorage());
        model.addAttribute("medicines_relative", groupedProducts);
        model.addAttribute("productPage", productPage); // Trang hiện tại của sản phẩm
        model.addAttribute("productPageSize", productPageSize); // Kích thước mỗi trang sản phẩm
        model.addAttribute("totalProductPages", medicines_relative.getTotalPages()); // Tổng số trang sản phẩm
        return "user/medicine/medicine-detail";
    }

    @PostMapping("/user/medicine/search")
    public String searchMedicineUser(Model model, @RequestParam("keyword") String keyword,
                                    @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                    @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize,
                                     RedirectAttributes redirectAttributes) {
            // Đảm bảo currentPage >= 1
            currentPage = Math.max(currentPage, 1);

            Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
            Page<MedicineForUserModel> medicines = medicineService.searchMedicineByKeywordForUser(keyword, pageable);

            if (medicines.isEmpty()) {
                redirectAttributes.addFlashAttribute("message", "Không tìm thấy thuốc");
                return "redirect:/user/medicines";
            }

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
                                     @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize,
                                     RedirectAttributes redirectAttributes) {

        // Kiểm tra các tham số đầu vào
        if (unitCostMin != null && unitCostMax != null && unitCostMin.compareTo(unitCostMax) > 0) {
            redirectAttributes.addFlashAttribute("message", "Giá min phải nhỏ hơn hoặc bằng giá max");
            return "user/medicine/medicines-list";
        }
        if (expiryDateMin != null && expiryDateMax != null && expiryDateMin.compareTo(expiryDateMax) > 0) {
            redirectAttributes.addFlashAttribute("message", "Ngày hết hạn min phải nhỏ hơn hoặc bằng ngày hết hạn max");
            return "user/medicine/medicines-list";
        }
        if (stockQuantityMin != null && stockQuantityMax != null && stockQuantityMin.compareTo(stockQuantityMax) > 0) {
            redirectAttributes.addFlashAttribute("message", "Số lượng min phải nhỏ hơn hoặc bằng số lượng max");
            return "user/medicine/medicines-list";
        }
        if (ratingMin != null && ratingMax != null && ratingMin.compareTo(ratingMax) > 0) {
            redirectAttributes.addFlashAttribute("message", "Đánh giá min phải nhỏ hơn hoặc bằng đánh giá max");
            return "user/medicine/medicines-list";
        }

        // Gọi service để lấy danh sách thuốc đã lọc
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize);
        Page<MedicineForUserModel> filteredMedicines = medicineService.filterMedicineFlexibleForUser(
                manufacturerName, categoryName, unitName, unitCostMin, unitCostMax,
                expiryDateMin, expiryDateMax, stockQuantityMin, stockQuantityMax,
                ratingMin, ratingMax, pageable
        );

        if (filteredMedicines.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Không tìm thấy thuốc");
            return "redirect:/user/medicines";
        }

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
