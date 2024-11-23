package gr.careplus4.services.impl;

import gr.careplus4.models.MedicineForUserModel;
import gr.careplus4.services.MedicineSpecifications;
import gr.careplus4.entities.Medicine;
import gr.careplus4.repositories.MedicineRepository;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.iMedicineServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

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
    public Boolean medicineIsExist(String name, Date expireDate, String Manufacture, Date importDate) {
        return medicineRepository.existsByNameAndExpiryDateAndManufacturer_NameAndImportDate(name, expireDate, Manufacture, importDate);
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
            Date expiryDateMin, Date expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax,
            Date importDateMin, Date importDateMax,
            Pageable pageable
    ) {
        Specification<Medicine> specification = MedicineSpecifications.buildSpecification(
                manufacturerName, categoryName, unitName, unitCostMin, unitCostMax,
                expiryDateMin, expiryDateMax, stockQuantityMin, stockQuantityMax,
                ratingMin, ratingMax, importDateMin, importDateMax
        );
        return  medicineRepository.findAll(specification , pageable);
    }

    @Override
    public Medicine findTopByOrderByIdDesc() {
        return medicineRepository.findTopByOrderByIdDesc();
    }

    public String generateMedicineId(String previousId) {
        return GeneratedId.getGeneratedId(previousId);
    }

    @Override
    public List<Medicine> findByImportDateBetween(Date min, Date max) {
        return medicineRepository.findByImportDateBetween(min, max);
    }

    @Override
    public List<Medicine> findByImportDateBetween(Date min, Date max, Pageable pageable) {
        return medicineRepository.findByImportDateBetween(min, max, pageable);
    }

    @Override
    public List<Medicine> findByExpiryDateBetween(Date min, Date max) {
        return medicineRepository.findByExpiryDateBetween(min, max);
    }

    @Override
    public List<Medicine> findByExpiryDateBetween(Date min, Date max, Pageable pageable) {
        return medicineRepository.findByExpiryDateBetween(min, max, pageable);
    }

    @Override
    public Optional<Medicine> getMedicineByNameAndExpiryDateAndManufacturer_NameAndImportDate(String name, Date expireDate, String Manufacture, Date importDate) {
        return medicineRepository.findByNameAndExpiryDateAndManufacturer_NameAndImportDate(name, expireDate, Manufacture, importDate);
    }

    @Override
    public void updateUnitPriceFollowUniCost(String name, String manufacturerName, Date expiryDate, Date currentDate, BigDecimal unitCost) {
        Optional<Medicine> medicine = getMedicineByNameAndExpiryDateAndManufacturer_NameAndImportDate(name, expiryDate, manufacturerName, currentDate);
        BigDecimal unitPrice = unitCost.multiply(new BigDecimal(1.45)); // Giá bán = Giá vốn * 1.45
        if (medicine.isPresent()) {
            medicine.get().setUnitCost(unitPrice);
            medicineRepository.save(medicine.get());
        } else {
            System.out.println("Medicine not found");
        }
    }

    @Override
    public void updateStockQuantity(String name, String manufacturerName, Date expiryDate, Date currentDate, Integer quantity) {
        Optional<Medicine> medicine = getMedicineByNameAndExpiryDateAndManufacturer_NameAndImportDate(name, expiryDate, manufacturerName, currentDate);
        if (medicine.isPresent()) {
            Integer stockQuantity = medicine.get().getStockQuantity() + quantity;
            medicine.get().setStockQuantity(stockQuantity);
            medicineRepository.save(medicine.get());
        } else {
            System.out.println("Medicine not found");
        }
    }

    @Override
    public void updateTotalRatingForMedicine(String name, String manufacturerName, BigDecimal rating) {
        List<Medicine> medicines = medicineRepository.findByNameAndManufacturer_Name(name, manufacturerName);
        if (medicines.size() > 0) {
            for (Medicine medicine : medicines) {
                BigDecimal totalRating = medicine.getRating();
                totalRating = (totalRating.add(rating)).divide(new BigDecimal(2));
                medicine.setRating(totalRating);
                medicineRepository.save(medicine);
            }
        } else {
            System.out.println("Medicine not found");
        }
    }

    @Override
    public List<Medicine> findMedicinesByNameAndManufacturer_NameAndDosage(String name, String manufacturerName, String dosage) {
        return medicineRepository.findMedicinesByNameAndManufacturer_NameAndDosage(name, manufacturerName, dosage);
    }

    @Override
    public List<MedicineForUserModel> findNearestExpiryMedicines() {
        // Lấy toàn bộ danh sách thuốc từ database
        List<Medicine> medicines = medicineRepository.findAll();

        // Nhóm các thuốc theo name, manufacturerName, và dosage
        return medicines.stream()
                .collect(Collectors.groupingBy(
                        // Key: Kết hợp name, manufacturerName, và dosage
                        medicine -> medicine.getName() + "|" +
                                medicine.getManufacturer().getName() + "|" +
                                medicine.getDosage(),
                        // Value: Danh sách các thuốc trong nhóm
                        Collectors.toList()
                ))
                .values().stream()
                .map(groupedMedicines -> {
                    // Lấy thuốc có expiryDate gần nhất trong nhóm
                    Medicine nearestExpiryMedicine = groupedMedicines.stream()
                            .min(Comparator.comparing(Medicine::getExpiryDate))
                            .orElseThrow();

                    // Chuyển đổi sang MedicineForUserModel, bao gồm ID của entity
                    return new MedicineForUserModel(
                            nearestExpiryMedicine.getId(), // Truyền ID từ entity vào DTO
                            nearestExpiryMedicine.getName(),
                            nearestExpiryMedicine.getDescription(),
                            nearestExpiryMedicine.getUnitCost(),
                            nearestExpiryMedicine.getStockQuantity(),
                            nearestExpiryMedicine.getDosage(),
                            nearestExpiryMedicine.getRating(),
                            nearestExpiryMedicine.getManufacturer().getName(),
                            nearestExpiryMedicine.getCategory().getName(),
                            nearestExpiryMedicine.getUnit().getName(),
                            nearestExpiryMedicine.getExpiryDate(),
                            nearestExpiryMedicine.getImage()
                    );
                })
                .toList();
    }

    @Override
    public Page<MedicineForUserModel> getMedicinesForUser(Pageable pageable) {
        // Lấy danh sách thuốc với expiry date gần nhất
        List<MedicineForUserModel> medicines = findNearestExpiryMedicines();

        // Tính toán phần tử bắt đầu và danh sách con dựa trên pageable
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int startItem = currentPage * pageSize;

        // Kiểm tra nếu phần tử bắt đầu lớn hơn tổng số thuốc
        List<MedicineForUserModel> list;
        if (startItem >= medicines.size()) {
            list = new ArrayList<>(); // Nếu vượt quá phạm vi, trả về danh sách rỗng
        } else {
            int toIndex = Math.min(startItem + pageSize, medicines.size());
            list = medicines.subList(startItem, toIndex); // Lấy danh sách con
        }

        // Trả về Page chứa danh sách thuốc đã phân trang
        return new PageImpl<>(list, pageable, medicines.size());
    }

    @Override
    public Optional<MedicineForUserModel> findMedicineByIdForUser(String id) {
        // Lấy danh sách thuốc đã lọc theo ngày hết hạn gần nhất
        List<MedicineForUserModel> medicines = findNearestExpiryMedicines();

        // Duyệt danh sách và tìm thuốc có ID khớp
        return medicines.stream()
                .filter(medicine -> medicine.getId().equals(id))
                .findFirst(); // Trả về Optional<MedicineForUserModel>
    }

    @Override
    public List<MedicineForUserModel> containsKeywordInAttributesForUser(
            List<MedicineForUserModel> medicines, String keyword) {

        String likePattern = keyword.toLowerCase(); // Chuyển từ khóa thành chữ thường

        return medicines.stream()
                .filter(medicine ->
                        // Kiểm tra xem từ khóa có tồn tại trong các thuộc tính của thuốc hay không
                        (medicine.getName() != null && medicine.getName().toLowerCase().contains(likePattern)) ||
                                (medicine.getCategoryName() != null && medicine.getCategoryName().toLowerCase().contains(likePattern)) ||
                                (medicine.getManufacturerName() != null && medicine.getManufacturerName().toLowerCase().contains(likePattern)) ||
                                (medicine.getDescription() != null && medicine.getDescription().toLowerCase().contains(likePattern)) ||
                                (medicine.getUnitName() != null && medicine.getUnitName().toLowerCase().contains(likePattern)) ||
                                (medicine.getDosage() != null && medicine.getDosage().toLowerCase().contains(likePattern))
                )
                .toList(); // Trả về danh sách các thuốc khớp với từ khóa
    }

    @Override
    public Page<MedicineForUserModel> searchMedicineByKeywordForUser(String keyword, Pageable pageable) {
        List<MedicineForUserModel> medicines = findNearestExpiryMedicines();

        List<MedicineForUserModel> searchResult = containsKeywordInAttributesForUser(medicines, keyword);

        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int startItem = currentPage * pageSize;

        List<MedicineForUserModel> pagedMedicines;
        if (startItem >= searchResult.size()) {
            pagedMedicines = new ArrayList<>(); // Nếu vượt quá phạm vi, trả về danh sách rỗng
        } else {
            int toIndex = Math.min(startItem + pageSize, searchResult.size());
            pagedMedicines = searchResult.subList(startItem, toIndex);
        }

        return new PageImpl<>(pagedMedicines, pageable, searchResult.size());

    }

    @Override
    public List<MedicineForUserModel> filterForUser(
            List<MedicineForUserModel> medicines,
            String manufacturerName, String categoryName, String unitName,
            BigDecimal unitCostMin, BigDecimal unitCostMax,
            Date expiryDateMin, Date expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax
    ) {
        return medicines.stream()
                .filter(medicine ->
                        // Kiểm tra manufacturerName
                        (manufacturerName == null || manufacturerName.equals(medicine.getManufacturerName())) &&

                                // Kiểm tra categoryName
                                (categoryName == null || categoryName.equals(medicine.getCategoryName())) &&

                                // Kiểm tra unitName
                                (unitName == null || unitName.equals(medicine.getUnitName())) &&

                                // Kiểm tra unitCost
                                (medicine.getUnitCost() != null &&
                                        medicine.getUnitCost().compareTo(BigDecimal.ZERO) >= 0 && // unitCost không âm
                                        (unitCostMin == null && unitCostMax == null ||
                                                (unitCostMin == null || medicine.getUnitCost().compareTo(unitCostMin) >= 0) &&
                                                        (unitCostMax == null || medicine.getUnitCost().compareTo(unitCostMax) <= 0))) &&

                                // Kiểm tra expiryDate
                                (expiryDateMin == null && expiryDateMax == null ||
                                        (medicine.getExpiryDate() != null &&
                                                (expiryDateMin == null || !medicine.getExpiryDate().before(expiryDateMin)) &&
                                                (expiryDateMax == null || !medicine.getExpiryDate().after(expiryDateMax)))) &&

                                // Kiểm tra stockQuantity
                                (stockQuantityMin == null && stockQuantityMax == null ||
                                        (medicine.getStockQuantity() >= 0 && // Giá trị stockQuantity không âm
                                                (stockQuantityMin == null || medicine.getStockQuantity() >= stockQuantityMin) &&
                                                (stockQuantityMax == null || medicine.getStockQuantity() <= stockQuantityMax))) &&

                                // Kiểm tra rating
                                (medicine.getRating() != null &&
                                        medicine.getRating().compareTo(BigDecimal.ONE) >= 0 && // Rating >= 1.0
                                        medicine.getRating().compareTo(new BigDecimal("5.0")) <= 0 && // Rating <= 5.0
                                        (ratingMin == null && ratingMax == null ||
                                                (ratingMin == null || medicine.getRating().compareTo(ratingMin) >= 0) &&
                                                        (ratingMax == null || medicine.getRating().compareTo(ratingMax) <= 0)))
                )
                .toList();
    }

    @Override
    public Page<MedicineForUserModel> filterMedicineFlexibleForUser(
            String manufacturerName, String categoryName, String unitName,
            BigDecimal unitCostMin, BigDecimal unitCostMax,
            Date expiryDateMin, Date expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax,
            Pageable pageable
    ) {
        // Lấy danh sách thuốc gần hết hạn
        List<MedicineForUserModel> medicines = findNearestExpiryMedicines();

        // Áp dụng bộ lọc
        List<MedicineForUserModel> filteredMedicines = filterForUser(
                medicines, manufacturerName, categoryName, unitName,
                unitCostMin, unitCostMax, expiryDateMin, expiryDateMax,
                stockQuantityMin, stockQuantityMax, ratingMin, ratingMax
        );

        // Tính toán phân trang
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int startItem = currentPage * pageSize;

        List<MedicineForUserModel> pagedMedicines;
        if (startItem >= filteredMedicines.size()) {
            pagedMedicines = new ArrayList<>(); // Nếu vượt quá phạm vi, trả về danh sách rỗng
        } else {
            int toIndex = Math.min(startItem + pageSize, filteredMedicines.size());
            pagedMedicines = filteredMedicines.subList(startItem, toIndex);
        }

        // Trả về đối tượng Page<MedicineForUserModel>
        return new PageImpl<>(pagedMedicines, pageable, filteredMedicines.size());
    }
}
