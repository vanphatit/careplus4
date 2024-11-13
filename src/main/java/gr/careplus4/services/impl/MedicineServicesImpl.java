package gr.careplus4.services.impl;

import gr.careplus4.controllers.medicines.api.MedicineSpecifications;
import gr.careplus4.entities.Medicine;
import gr.careplus4.repositories.MedicineRepository;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.iMedicineServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class MedicineServicesImpl implements iMedicineServices {
    @Autowired
    MedicineRepository medicineRepository;

    @Override
    public List<Medicine> findByNameContaining(String name) {
        return medicineRepository.findByNameContaining(name);
    }

    @Override
    public List<Medicine> findByNameContaining(String name, Pageable pageable) {
        return medicineRepository.findByNameContaining(name, pageable);
    }

    @Override
    public List<Medicine> findByDescriptionContaining(String description) {
        return medicineRepository.findByDescriptionContaining(description);
    }

    @Override
    public List<Medicine> findByDescriptionContaining(String description, Pageable pageable) {
        return medicineRepository.findByDescriptionContaining(description, pageable);
    }

    @Override
    public List<Medicine> findByUnitCostBetween(BigDecimal min, BigDecimal max) {
        return medicineRepository.findByUnitCostBetween(min, max);
    }

    @Override
    public List<Medicine> findByUnitCostBetween(BigDecimal min, BigDecimal max, Pageable pageable) {
        return medicineRepository.findByUnitCostBetween(min, max, pageable);
    }

    @Override
    public List<Medicine> findByManufacturer_Name(String nameManufacture) {
        return medicineRepository.findByManufacturer_Name(nameManufacture);
    }

    @Override
    public List<Medicine> findByManufacturer_Name(String nameManufacture, Pageable pageable) {
        return medicineRepository.findByManufacturer_Name(nameManufacture, pageable);
    }

    @Override
    public List<Medicine> findByCategory_Name(String nameCategory) {
        return medicineRepository.findByCategory_Name(nameCategory);
    }

    @Override
    public List<Medicine> findByCategory_Name(String nameCategory, Pageable pageable) {
        return medicineRepository.findByCategory_Name(nameCategory, pageable);
    }

    @Override
    public List<Medicine> findByRatingBetween(BigDecimal min, BigDecimal max) {
        return medicineRepository.findByRatingBetween(min, max);
    }

    @Override
    public List<Medicine> findByRatingBetween(BigDecimal min, BigDecimal max, Pageable pageable) {
        return medicineRepository.findByRatingBetween(min, max, pageable);
    }

    @Override
    public List<Medicine> findByStockQuantityBetween(Integer min, Integer max) {
        return medicineRepository.findByStockQuantityBetween(min, max);
    }

    @Override
    public List<Medicine> findByStockQuantityBetween(Integer min, Integer max, Pageable pageable) {
        return medicineRepository.findByStockQuantityBetween(min, max, pageable);
    }

    @Override
    public List<Medicine> findAll() {
        return medicineRepository.findAll();
    }

    @Override
    public <S extends Medicine> S save(S entity) {
        if (entity.getId() == null) {
            // Lấy ID lớn nhất hiện có và tạo ID mới
            Medicine medicineWithMaxId = findTopByOrderByIdDesc();
            String previousId = (medicineWithMaxId != null) ? medicineWithMaxId.getId() : "M000000";
            entity.setId(GeneratedId.getGeneratedId(previousId));
            return medicineRepository.save(entity);
        } else {
            Optional<Medicine> existingMedicine = medicineRepository.findById(entity.getId());
            if (existingMedicine.isPresent()) {
                // Kiểm tra xem có image mới không, nếu không thì giữ lại image cũ
                if (StringUtils.isEmpty(entity.getImage())) {
                    entity.setImage(existingMedicine.get().getImage());
                } else {
                    entity.setImage(entity.getImage());
                }
            }
            return medicineRepository.save(entity);
        }
    }

    @Override
    public long count() {
        return medicineRepository.count();
    }

    @Override
    public Optional<Medicine> findById(String s) {
        return medicineRepository.findById(s);
    }

    @Override
    public void deleteById(String s) {
        medicineRepository.deleteById(s);
    }

    @Override
    public Page<Medicine> findAll(Pageable pageable) {
        return medicineRepository.findAll(pageable);
    }

    @Override
    public Boolean medicineIsExist(String name, Date expireDate, String Manufacture) {
        return medicineRepository.existsByNameAndExpiryDateAndManufacturer_Name(name, expireDate, Manufacture);
    }

    @Override
    public Page<Medicine> searchMedicineByKeyword(String keyword, Pageable pageable) {
        Specification<Medicine> specification = MedicineSpecifications.containsKeywordInAttributes(keyword);
        return medicineRepository.findAll(specification, pageable);
    }

    @Override
    public Page<Medicine> filterMedicineFlexible(
            String manufacturerName, String categoryName, String unitName,
            BigDecimal unitCostMin, BigDecimal unitCostMax,
            Long expiryDateMin, Long expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax,
            Pageable pageable
    ) {
        Specification<Medicine> specification = MedicineSpecifications.buildSpecification(
                manufacturerName, categoryName, unitName, unitCostMin, unitCostMax,
                expiryDateMin, expiryDateMax, stockQuantityMin, stockQuantityMax,
                ratingMin, ratingMax
        );
        return  medicineRepository.findAll(specification , pageable);
    }

    @Override
    public Medicine findTopByOrderByIdDesc() {
        return medicineRepository.findTopByOrderByIdDesc();
    }
}
