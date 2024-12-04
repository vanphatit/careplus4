package gr.careplus4.services;

import gr.careplus4.entities.Medicine;
import gr.careplus4.models.MedicineForUserModel;
import gr.careplus4.services.impl.MedicineServicesImpl;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.*;

public interface iMedicineServices {

    List<Medicine> findByNameContaining(String name);

    List<Medicine> findByNameContaining(String name, Pageable pageable);

    List<Medicine> findByDescriptionContaining(String description);

    List<Medicine> findByDescriptionContaining(String description, Pageable pageable);

    List<Medicine> findByUnitCostBetween(BigDecimal min, BigDecimal max);

    List<Medicine> findByUnitCostBetween(BigDecimal min, BigDecimal max, Pageable pageable);

    List<Medicine> findByManufacturer_Name(String nameManufacture);

    List<Medicine> findByManufacturer_Name(String nameManufacture, Pageable pageable);

    List<Medicine> findByCategory_Name(String nameCategory);

    List<Medicine> findByCategory_Name(String nameCategory, Pageable pageable);

    List<Medicine> findByRatingBetween(BigDecimal min, BigDecimal max);

    List<Medicine> findByRatingBetween(BigDecimal min, BigDecimal max, Pageable pageable);

    List<Medicine> findByStockQuantityBetween(Integer min, Integer max);

    List<Medicine> findByStockQuantityBetween(Integer min, Integer max, Pageable pageable);

    List<Medicine> findAll();

    <S extends Medicine> S save(S entity);

    long count();

    Optional<Medicine> findById(String s);

    void deleteById(String s);

    Page<Medicine> findAll(Pageable pageable);


    Boolean medicineIsExist(String name, Date expireDate, String Manufacture, Date importDate);

    Page<Medicine> searchMedicineByKeyword(String keyword, Pageable pageable);


    Page<Medicine> filterMedicineFlexible(
            String manufacturerName, String categoryName, String unitName,
            BigDecimal unitCostMin, BigDecimal unitCostMax,
            Date expiryDateMin, Date expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax,
            Date importDateMin, Date importDateMax,
            Pageable pageable
    );

    Medicine findTopByOrderByIdDesc();

    String generateMedicineId(String previousId);

    List<Medicine> findByImportDateBetween(Date min, Date max);

    List<Medicine> findByImportDateBetween(Date min, Date max, Pageable pageable);

    List<Medicine> findByExpiryDateBetween(Date min, Date max);

    List<Medicine> findByExpiryDateBetween(Date min, Date max, Pageable pageable);

    Optional<Medicine> getMedicineByNameAndExpiryDateAndManufacturer_NameAndImportDate(String name, Date expireDate, String Manufacture, Date importDate);

    void updateUnitPriceFollowUniCost(String name, String manufacturerName, Date expiryDate, Date currentDate, BigDecimal unitCost);

    void updateStockQuantity(String name, String manufacturerName, Date expiryDate, Date currentDate, Integer quantity);

    void updateTotalRatingForMedicine(String name, String manufacturerName, BigDecimal rating);

    List<Medicine> findMedicinesByNameAndManufacturer_NameAndDosage(String name, String manufacturerName, String dosage);

    List<MedicineForUserModel> findNearestExpiryMedicines();

    Page<MedicineForUserModel> getMedicinesForUser(Pageable pageable);

    Optional<MedicineForUserModel> findMedicineByIdForUser(String id);

    List<MedicineForUserModel> containsKeywordInAttributesForUser(
            List<MedicineForUserModel> medicines, String keyword);

    Page<MedicineForUserModel> searchMedicineByKeywordForUser(String keyword, Pageable pageable);

    List<MedicineForUserModel> filterForUser(
            List<MedicineForUserModel> medicines,
            String manufacturerName, String categoryName, String unitName,
            BigDecimal unitCostMin, BigDecimal unitCostMax,
            Date expiryDateMin, Date expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax
    );

    Page<MedicineForUserModel> filterMedicineFlexibleForUser(
            String manufacturerName, String categoryName, String unitName,
            BigDecimal unitCostMin, BigDecimal unitCostMax,
            Date expiryDateMin, Date expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax,
            Pageable pageable
    );

    List<MedicineForUserModel> findTop10SellingMedicinesFromUniqueList();

    List<MedicineForUserModel> getRelatedProducts(String id, String cateName, Pageable pageable);

    Map<String, Object> parseDescription(String description, String medicineName);
}
