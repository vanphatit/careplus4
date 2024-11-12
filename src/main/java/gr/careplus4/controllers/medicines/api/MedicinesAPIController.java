package gr.careplus4.controllers.medicines.api;

import gr.careplus4.entities.Category;
import gr.careplus4.entities.Manufacturer;
import gr.careplus4.models.Response;
import gr.careplus4.services.iManufacturerServices;
import gr.careplus4.services.iStorageServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import gr.careplus4.services.iMedicineServices;
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
    private iMedicineServices medicinesService;

    @Autowired
    private iManufacturerServices manufacturerService;

    @Autowired
    private iStorageServices storageService;

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

//    // thêm một thuốc mới
//    @PostMapping("/add")
//    public ResponseEntity<Response> addMedicine(@Validated @RequestParam("medicineName") String medicineName,
//                                                @Validated @RequestParam("expiredDate") Date expiredDate,
//                                                @Validated @RequestParam("manufacture") String manufactureName,
//                                                @RequestParam("image") MultipartFile image) {
//        Boolean check = medicinesService.medicineIsExist(medicineName, expiredDate, manufactureName);
//        if (check) {
//            Response Responses = new Response(false, "Thuốc đã tồn tại", null);
//            return new ResponseEntity<>(Responses, HttpStatus.BAD_REQUEST);
//        } else {
//            Medicine medicine = new Medicine();
//            medicine.setName(medicineName);
//            medicine.setImage(storageService.getStorageFilename(image, medicine.getId()));
//            medicinesService.save(medicine);
//            storageService.store(image, medicine.getImage());
//            Response Responses = new Response(true, "Thêm thuốc thành công", medicine);
//            return new ResponseEntity<>(Responses, HttpStatus.CREATED);
//        }
//    }

    // cập nhật thông tin một thuốc
//    @PutMapping("/update/{id}")
//    public ResponseEntity<Response> updateMedicine(@PathVariable String id,
//                                                   @Validated @RequestParam("medicineName") String medicineName,
//                                                   @Validated @RequestParam("Description") String Description,
//                                                   @Validated @RequestParam("unitCost") BigDecimal unitCost,
//                                                   @Validated @RequestParam("manufactureName") String manufactureName,
//                                                   @Validated @RequestParam("categoryName") String categoryName,
//                                                   @Validated @RequestParam("unitName") String unitName,
//                                                   @Validated @RequestParam("expiredDate") Date expiredDate,
//                                                   @Validated @RequestParam("stockQuantity") int stockQuantity,
//                                                   @Validated @RequestParam("dosage") String dosage,
//                                                   @Validated @RequestParam("rating") BigDecimal rating,
//                                                   @RequestParam("image") MultipartFile image) {
//        Optional<Medicine> existingMedicine = medicinesService.findById(id);
//        Category category = new Category(); // categoryService.findByCategoryName(categoryName).get();
//        Optional<Manufacturer> existingManufacturer = manufacturerService.findByName(manufactureName);
//        if (existingMedicine.isEmpty()) {
//            Response Responses = new Response(false, "Không tìm thấy thuốc", null);
//            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
//        } else {
//            Medicine medicine = existingMedicine.get();
//            medicine.setName(medicineName);
//            medicine.setDescription(Description);
//            medicine.setUnitCost(unitCost);
//            medicine.setManufacturer(existingManufacturer.get());
//            medicine.setCategory(category);
//            medicine.setUnitName(unitName);
//            medicine.setExpiryDate(expiredDate);
//            medicine.setStockQuantity(stockQuantity);
//            medicine.setDosage(dosage);
//            medicine.setRating(rating);
//            medicine.setImage(storageService.getStorageFilename(image, medicine.getId()));
//            medicinesService.save(medicine);
//            storageService.store(image, medicine.getImage());
//            Response Responses = new Response(true, "Cập nhật thuốc thành công", medicine);
//            return new ResponseEntity<>(Responses, HttpStatus.OK);
//        }

}
