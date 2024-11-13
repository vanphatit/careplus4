package gr.careplus4.controllers.medicines.api;

import gr.careplus4.entities.Category;
import gr.careplus4.entities.Manufacturer;
import gr.careplus4.entities.Unit;
import gr.careplus4.models.Response;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.impl.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import java.math.BigDecimal;

import gr.careplus4.entities.Medicine;
import org.springframework.web.multipart.MultipartFile;

import java.sql.SQLData;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
    public ResponseEntity<Response> getAllMedicines(Pageable pageable) {
        Page<Medicine> medicines = medicinesService.findAll(pageable);
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
                                                @Validated @RequestParam("description") String description,
                                                @Validated @RequestParam("unitCost") BigDecimal unitCost,
                                                @Validated @RequestParam("manufactureName") String manufactureName,
                                                @Validated @RequestParam("categoryName") String categoryName,
                                                @Validated @RequestParam("unitName") String unitName,
                                                @Validated @RequestParam("expiredDate") Date expiredDate,
                                                @Validated @RequestParam("stockQuantity") int stockQuantity,
                                                @Validated @RequestParam("dosage") String dosage,
                                                @RequestParam("image") MultipartFile image) {
        // Kiểm tra xem có tồn tại thuốc chưa
        Boolean check = medicinesService.medicineIsExist(medicineName, expiredDate, manufactureName);
        Optional<Category> category = categoryServices.findByCategoryName(categoryName);
        Optional<Manufacturer> manufacturer = manufacturerService.findByName(manufactureName);
        Optional<Unit> unit = unitServices.findByName(unitName);
        BigDecimal rating = new BigDecimal(0.0);
        if (check) {
            Response Responses = new Response(false, "Thuốc đã tồn tại", null);
            return new ResponseEntity<>(Responses, HttpStatus.BAD_REQUEST);
        } else {
            Medicine medicine = new Medicine();
            medicine.setName(medicineName);
            medicine.setDescription(description);
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
                                                   @Validated @RequestParam("description") String description,
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
            medicine.setDescription(description);
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
    public ResponseEntity<Response> searchMedicine(@PathVariable String keyword,
                                                   Pageable pageable
    ) {
        Page<Medicine> medicines = medicinesService.searchMedicineByKeyword(keyword, pageable);
        Response Responses = new Response(true, "Tìm kiếm thành công", medicines);
        return new ResponseEntity<>(Responses, HttpStatus.OK);
    }

    // Lọc động
    @GetMapping("/filter")
    public ResponseEntity<Response> filterMedicine(@RequestParam(value = "manufacturerName", required = false) String manufacturerName,
                                                   @RequestParam(value = "categoryName", required = false) String categoryName,
                                                   @RequestParam(value = "unitName", required = false) String unitName,
                                                   @RequestParam(value = "unitCostMin", required = false) BigDecimal unitCostMin,
                                                   @RequestParam(value = "unitCostMax", required = false) BigDecimal unitCostMax,
                                                   @RequestParam(value = "expiryDateMin", required = false) Long expiryDateMin,
                                                   @RequestParam(value = "expiryDateMax", required = false) Long expiryDateMax,
                                                   @RequestParam(value = "stockQuantityMin", required = false) Integer stockQuantityMin,
                                                   @RequestParam(value = "stockQuantityMax", required = false) Integer stockQuantityMax,
                                                   @RequestParam(value = "ratingMin", required = false) BigDecimal ratingMin,
                                                   @RequestParam(value = "ratingMax", required = false) BigDecimal ratingMax,
                                                   Pageable pageable
                                                   ) {
        Page<Medicine> medicines = medicinesService.filterMedicineFlexible(manufacturerName, categoryName, unitName, unitCostMin, unitCostMax, expiryDateMin, expiryDateMax, stockQuantityMin, stockQuantityMax, ratingMin, ratingMax, pageable);
        Response Responses = new Response(true, "Lọc thành công", medicines);
        return new ResponseEntity<>(Responses, HttpStatus.OK);
    }

    // Kiểm tra xem một thuốc có tồn tại không
    @GetMapping("/exist")
    public ResponseEntity<Response> medicineIsExist(@RequestParam("name") String name, @RequestParam("expireDate") String expireDate, @RequestParam("manufactureName") String manufactureName) {
        System.out.println(name);
        System.out.println(expireDate);
        System.out.println(manufactureName);

        Date date;
        try {
            // Định dạng ngày tháng cho "yyyy-MM-dd"
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            date = dateFormat.parse(expireDate);
        } catch (ParseException e) {
            // Xử lý khi ngày không hợp lệ
            Response response = new Response(false, "Ngày hết hạn không hợp lệ", null);
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }

        Boolean check = medicinesService.medicineIsExist(name, date, manufactureName);
        if (check) {
            Response Responses = new Response(true, "Thuốc đã tồn tại", null);
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        } else {
            Response Responses = new Response(false, "Thuốc chưa tồn tại", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
    }

}
