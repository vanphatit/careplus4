package gr.careplus4.controllers.medicines.api;

import gr.careplus4.entities.Category;
import gr.careplus4.entities.Manufacturer;
import gr.careplus4.entities.Unit;
import gr.careplus4.models.Response;
import gr.careplus4.services.impl.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import java.math.BigDecimal;

import gr.careplus4.entities.Medicine;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("v1/api/medicines")
public class MedicinesAPIController {
    @Autowired
    private MedicineServicesImpl medicinesService;

    @Autowired
    private ManufacturerServicesImpl manufacturerService;

    @Autowired
    private CategoryServiceImpl categoryServices;

    @Autowired
    private UnitServicesImpl unitServices;

    @Autowired
    private FileSystemStorageServiceImpl storageService;

    // lấy danh sách tất cả các thuốc
    @GetMapping
    public ResponseEntity<Response> getAllMedicines() {
        List<Medicine> medicines = medicinesService.findAll();
        Response Responses = new Response(true, "Lấy danh sách thành công", medicines);
        return new ResponseEntity<>(Responses, HttpStatus.OK);
    }

    // lấy một thuốc theo ID
    @GetMapping("/{id}")
    public ResponseEntity<Response> getMedicineById(@PathVariable String id) {
        Optional<Medicine> medicine = medicinesService.findById(id);
        if (medicine.isPresent()) {
            Response Responses = new Response(true, "Tìm thấy thuốc", medicine.get());
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        } else {
            Response Responses = new Response(false, "Không tìm thấy thuốc", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
    }

    // thêm một thuốc mới
    @PostMapping("/add")
    public ResponseEntity<Response> addMedicine(@Validated @RequestParam("medicineName") String medicineName,
                                                @Validated @RequestParam("Description") String Description,
                                                @Validated @RequestParam("unitCost") BigDecimal unitCost,
                                                @Validated @RequestParam("manufactureName") String manufactureName,
                                                @Validated @RequestParam("categoryName") String categoryName,
                                                @Validated @RequestParam("unitName") String unitName,
                                                @Validated @RequestParam("expiredDate") Date expiredDate,
                                                @Validated @RequestParam("stockQuantity") int stockQuantity,
                                                @Validated @RequestParam("dosage") String dosage,
                                                @Validated @RequestParam("rating") BigDecimal rating,
                                                @RequestParam("image") MultipartFile image) {
        // Kiem tra xem co ton tai thuoc nao trong database chua
        long count = medicinesService.count();
        String medicineId;
        if (count == 0) {
            medicineId = "M000001";
        } else {
            Medicine lastMedicine = medicinesService.findTopByOrderByIdDesc();
            String previousMedicineId = lastMedicine.getId();
//            medicineId = GenerateID.generateID(previousMedicineId);
        }

        Boolean check = medicinesService.medicineIsExist(medicineName, expiredDate, manufactureName);
        Optional<Category> category = categoryServices.findByCategoryName(categoryName);
        Optional<Manufacturer> manufacturer = manufacturerService.findByName(manufactureName);
        Optional<Unit> unit = unitServices.findByName(unitName);
        if (check) {
            Response Responses = new Response(false, "Thuốc đã tồn tại", null);
            return new ResponseEntity<>(Responses, HttpStatus.BAD_REQUEST);
        } else {
            Medicine medicine = new Medicine();
//            medicine.setId(medicineId);
            medicine.setName(medicineName);
            medicine.setDescription(Description);
            medicine.setUnitCost(unitCost);
            medicine.setManufacturer(manufacturer.get());
            medicine.setCategory(category.get());
            medicine.setUnit(unit.get());
            medicine.setExpiryDate(expiredDate);
            medicine.setStockQuantity(stockQuantity);
            medicine.setDosage(dosage);
            medicine.setRating(rating);
            medicine.setImage(storageService.getStorageFilename(image, medicine.getId()));
            medicinesService.save(medicine);
            storageService.store(image, medicine.getImage());
            Response Responses = new Response(true, "Thêm thuốc thành công", medicine);
            return new ResponseEntity<>(Responses, HttpStatus.CREATED);
        }
    }

    //cập nhật thông tin một thuốc
    @PutMapping("/update/{id}")
    public ResponseEntity<Response> updateMedicine(@PathVariable String id,
                                                   @Validated @RequestParam("medicineName") String medicineName,
                                                   @Validated @RequestParam("Description") String Description,
                                                   @Validated @RequestParam("unitCost") BigDecimal unitCost,
                                                   @Validated @RequestParam("manufactureName") String manufactureName,
                                                   @Validated @RequestParam("categoryName") String categoryName,
                                                   @Validated @RequestParam("unitName") String unitName,
                                                   @Validated @RequestParam("expiredDate") Date expiredDate,
                                                   @Validated @RequestParam("stockQuantity") int stockQuantity,
                                                   @Validated @RequestParam("dosage") String dosage,
                                                   @Validated @RequestParam("rating") BigDecimal rating,
                                                   @RequestParam("image") MultipartFile image) {
        Optional<Medicine> existingMedicine = medicinesService.findById(id);
        Optional<Category> category = categoryServices.findByCategoryName(categoryName);
        Optional<Manufacturer> manufacturer = manufacturerService.findByName(manufactureName);
        Optional<Unit> unit = unitServices.findByName(unitName);
        if (existingMedicine.isEmpty()) {
            Response Responses = new Response(false, "Không tìm thấy thuốc", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        } else {
            Medicine medicine = existingMedicine.get();
            medicine.setName(medicineName);
            medicine.setDescription(Description);
            medicine.setUnitCost(unitCost);
            medicine.setManufacturer(manufacturer.get());
            medicine.setCategory(category.get());
            medicine.setUnit(unit.get());
            medicine.setExpiryDate(expiredDate);
            medicine.setStockQuantity(stockQuantity);
            medicine.setDosage(dosage);
            medicine.setRating(rating);
            medicine.setImage(storageService.getStorageFilename(image, medicine.getId()));
            medicinesService.save(medicine);
            storageService.store(image, medicine.getImage());
            Response Responses = new Response(true, "Cập nhật thuốc thành công", medicine);
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        }
    }

    //Xóa một thuốc theo id
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Response> deleteMedicine(@PathVariable String id) {
        Optional<Medicine> medicine = medicinesService.findById(id);
        if (medicine.isEmpty()) {
            Response Responses = new Response(false, "Không tìm thấy thuốc", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
        medicinesService.deleteById(id);
        Response Responses = new Response(true, "Xóa thuốc thành công", null);
        return new ResponseEntity<>(Responses, HttpStatus.OK);
    }

    // Tìm kiếm theo keyword
    @GetMapping("/search/{keyword}")
    public ResponseEntity<Response> searchMedicine(@PathVariable String keyword) {
        List<Medicine> medicines = medicinesService.searchMedicineByKeyword(keyword);
        Response Responses = new Response(true, "Tìm kiếm thành công", medicines);
        return new ResponseEntity<>(Responses, HttpStatus.OK);
    }

    // Lọc động
    @GetMapping("/filter")
    public ResponseEntity<Response> filterMedicine(@RequestParam(value = "manufacturerId", required = false) String manufacturerId,
                                                   @RequestParam(value = "categoryId", required = false) String categoryId,
                                                   @RequestParam(value = "unitId", required = false) String unitId,
                                                   @RequestParam(value = "unitCostMin", required = false) BigDecimal unitCostMin,
                                                   @RequestParam(value = "unitCostMax", required = false) BigDecimal unitCostMax,
                                                   @RequestParam(value = "expiryDateMin", required = false) Long expiryDateMin,
                                                   @RequestParam(value = "expiryDateMax", required = false) Long expiryDateMax,
                                                   @RequestParam(value = "stockQuantityMin", required = false) Integer stockQuantityMin,
                                                   @RequestParam(value = "stockQuantityMax", required = false) Integer stockQuantityMax,
                                                   @RequestParam(value = "ratingMin", required = false) BigDecimal ratingMin,
                                                   @RequestParam(value = "ratingMax", required = false) BigDecimal ratingMax) {
        List<Medicine> medicines = medicinesService.filterMedicineFlexible(manufacturerId, categoryId, unitId, unitCostMin, unitCostMax, expiryDateMin, expiryDateMax, stockQuantityMin, stockQuantityMax, ratingMin, ratingMax);
        Response Responses = new Response(true, "Lọc thành công", medicines);
        return new ResponseEntity<>(Responses, HttpStatus.OK);
    }

    // Phân trang
//    @GetMapping("/page")
//    public ResponseEntity<Response> getMedicinesByPage(@RequestParam(value = "page", defaultValue = "0") int page,
//                                                       @RequestParam(value = "size", defaultValue = "10") int size) {
//        List<Medicine> medicines = medicinesService.findMedicinesByPage(page, size);
//        Response Responses = new Response(true, "Lấy danh sách thành công", medicines);
//        return new ResponseEntity<>(Responses, HttpStatus.OK);
//    }

}
