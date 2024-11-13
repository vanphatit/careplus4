package gr.careplus4.services;

import gr.careplus4.entities.Medicine;
import gr.careplus4.services.impl.MedicineServicesImpl;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Optional;

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


    Boolean medicineIsExist(String name, Date expireDate, String Manufacture);

    Page<Medicine> searchMedicineByKeyword(String keyword, Pageable pageable);

    Page<Medicine> filterMedicineFlexible(
            String manufacturerName, String categoryName, String unitName,
            BigDecimal unitCostMin, BigDecimal unitCostMax,
            Long expiryDateMin, Long expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax,
            Pageable pageable
    );

    Medicine findTopByOrderByIdDesc();
}
