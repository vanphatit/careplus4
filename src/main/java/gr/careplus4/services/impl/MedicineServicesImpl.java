package gr.careplus4.services.impl;

import gr.careplus4.entities.BillDetail;
import gr.careplus4.entities.Category;
import gr.careplus4.models.MedicineForUserModel;
import gr.careplus4.repositories.BillDetailRepository;
import gr.careplus4.repositories.CategoryRepository;
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
import java.math.RoundingMode;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class MedicineServicesImpl implements iMedicineServices {
    @Autowired
    MedicineRepository medicineRepository;

    @Autowired
    BillDetailRepository billDetailRepository;

    @Autowired
    CategoryRepository categoryRepository;

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
    public Boolean checkMedicineIsDeleted(BigDecimal unitCost) {
        if (unitCost.compareTo(BigDecimal.ZERO) == 0) {
            return true;
        }
        return false;
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

        return  medicineRepository.findAll(specification, pageable);
    }

    @Override
    public Medicine findTopByOrderByIdDesc() {
        return medicineRepository.findTopByOrderByIdDesc();
    }

    public String generateMedicineId(String previousId) {
        return GeneratedId.getGeneratedId(previousId);
    }

    @Override
    public int countAllStockQuantity() {
        List<Medicine> medicines = medicineRepository.findAll();
        return medicines.stream()
                .mapToInt(Medicine::getStockQuantity)
                .sum();
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
    public void updateTotalRatingForMedicine(String name, String manufacturerName, BigDecimal newRating) {
        // Tìm danh sách thuốc theo tên và nhà sản xuất
        List<Medicine> medicines = medicineRepository.findByNameAndManufacturer_Name(name, manufacturerName);

        if (!medicines.isEmpty()) {
            BigDecimal totalRatings = BigDecimal.ZERO;
            int totalMedicines = medicines.size(); // Số lượng thuốc có cùng tên và nhà sản xuất

            // Tính tổng điểm đánh giá hiện có
            for (Medicine medicine : medicines) {
                if (medicine.getRating() != null) {
                    totalRatings = totalRatings.add(medicine.getRating());
                }
            }

            // Thêm điểm đánh giá mới vào tổng
            totalRatings = totalRatings.add(newRating);

            // Tính điểm trung bình
            BigDecimal averageRating = totalRatings.divide(BigDecimal.valueOf(totalMedicines + 1), 2, RoundingMode.HALF_UP);

            // Cập nhật lại tất cả thuốc có cùng tên và nhà sản xuất
            for (Medicine medicine : medicines) {
                medicine.setRating(averageRating);
                medicineRepository.save(medicine);
            }

            System.out.println("Đánh giá trung bình mới đã được cập nhật cho các thuốc tên: "
                    + name + " của nhà sản xuất: " + manufacturerName);
        } else {
            System.out.println("Không tìm thấy thuốc với tên: " + name + " và nhà sản xuất: " + manufacturerName);
        }
    }

    @Override
    public List<Medicine> findMedicinesByNameAndManufacturer_NameAndDosage(String name, String manufacturerName, String dosage) {
        return medicineRepository.findMedicinesByNameAndManufacturer_NameAndDosage(name, manufacturerName, dosage);
    }

    @Override
    public List<Medicine> getTop5BestSellerForMonth() {
        // Lấy ngày hiện tại và 30 ngày trước
        java.sql.Date now = new java.sql.Date(System.currentTimeMillis());
        java.sql.Date thirtyDaysAgo = new java.sql.Date(System.currentTimeMillis() - 30 * 24 * 60 * 60 * 1000);

        // Lấy danh sách BillDetail trong 30 ngày gần đây
        List<BillDetail> recentBillDetails = billDetailRepository.findAllByBillDateBetween(thirtyDaysAgo, now);

        // Tính tổng số lượng bán ra cho mỗi sản phẩm
        Map<String, Integer> medicineSales = recentBillDetails.stream()
                .collect(Collectors.groupingBy(
                        billDetail -> billDetail.getMedicine().getId(), // Nhóm theo ID thuốc
                        Collectors.summingInt(BillDetail::getQuantity)  // Tổng số lượng bán ra
                ));

        // Sắp xếp các sản phẩm theo tổng số lượng bán được giảm dần và lấy top 5
        List<String> topMedicineIds = medicineSales.entrySet().stream()
                .sorted((entry1, entry2) -> Integer.compare(entry2.getValue(), entry1.getValue()))
                .limit(3) // Lấy top 5 sản phẩm
                .map(Map.Entry::getKey) // Chỉ lấy ID
                .toList();

        // Lấy thông tin chi tiết của các sản phẩm
        return medicineRepository.findAllById(topMedicineIds);
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
                            nearestExpiryMedicine.getImage(),
                            null, null, null, null, null, null
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
                .filter(medicine -> {
                    // Kiểm tra manufacturerName
                    if (manufacturerName != null && !manufacturerName.isEmpty() &&
                            !manufacturerName.equalsIgnoreCase(medicine.getManufacturerName())) {
                        return false;
                    }

                    // Kiểm tra categoryName
                    if (categoryName != null && !categoryName.isEmpty() &&
                            !categoryName.equalsIgnoreCase(medicine.getCategoryName())) {
                        return false;
                    }

                    // Kiểm tra unitName
                    if (unitName != null && !unitName.isEmpty() &&
                            !unitName.equalsIgnoreCase(medicine.getUnitName())) {
                        return false;
                    }

                    // Kiểm tra unitCost
                    if (medicine.getUnitCost() != null) {
                        if (unitCostMin != null && medicine.getUnitCost().compareTo(unitCostMin) < 0) {
                            return false;
                        }
                        if (unitCostMax != null && medicine.getUnitCost().compareTo(unitCostMax) > 0) {
                            return false;
                        }
                    }

                    // Kiểm tra expiryDate
                    if (medicine.getExpiryDate() != null) {
                        if (expiryDateMin != null && medicine.getExpiryDate().before(expiryDateMin)) {
                            return false;
                        }
                        if (expiryDateMax != null && medicine.getExpiryDate().after(expiryDateMax)) {
                            return false;
                        }
                    }

                    // Kiểm tra stockQuantity
                    if (medicine.getStockQuantity() != 0) {
                        if (stockQuantityMin != null && medicine.getStockQuantity() < stockQuantityMin) {
                            return false;
                        }
                        if (stockQuantityMax != null && medicine.getStockQuantity() > stockQuantityMax) {
                            return false;
                        }
                    }

                    // Kiểm tra rating
                    if (medicine.getRating() != null) {
                        if (ratingMin != null && medicine.getRating().compareTo(ratingMin) < 0) {
                            return false;
                        }
                        if (ratingMax != null && medicine.getRating().compareTo(ratingMax) > 0) {
                            return false;
                        }
                    }

                    // Tất cả điều kiện đều đúng
                    return true;
                })
                .toList();
    }


    @Override
    public Page<MedicineForUserModel> getMedicineForUserByCategoryName(String categoryName, Pageable pageable) {
        List<MedicineForUserModel> medicines = findNearestExpiryMedicines();

        List<MedicineForUserModel> filteredMedicines = medicines.stream()
                .filter(medicine -> {
                    Optional<Category> optionalCategory = categoryRepository.findByName(categoryName);

                    // Kiểm tra nếu không tìm thấy category
                    if (optionalCategory.isEmpty()) {
                        return false;
                    }

                    Category category = optionalCategory.get();

                    // Nếu category là parent, lọc theo chính nó và các category con
                    if (category.getParentCategory() == null) {
                        // Lấy tất cả các category con của parent category
                        List<String> subCategories = categoryRepository.findByParentCategoryId(category.getId())
                                .stream()
                                .map(Category::getName)
                                .collect(Collectors.toList());

                        // Kiểm tra nếu categoryName khớp với parent hoặc bất kỳ category con nào
                        return categoryName.equalsIgnoreCase(medicine.getCategoryName()) ||
                                subCategories.contains(medicine.getCategoryName());
                    }

                    // Nếu category là sub-category, chỉ lọc theo chính nó
                    return categoryName.equalsIgnoreCase(medicine.getCategoryName());
                })
                .toList();

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

        return new PageImpl<>(pagedMedicines, pageable, filteredMedicines.size());
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

    @Override
    public List<MedicineForUserModel> findTop9SellingMedicinesFromUniqueList() {

        Set<MedicineForUserModel> uniqueList = new HashSet<>(findNearestExpiryMedicines());

        return uniqueList.stream()
                .map(medicine -> {
                    // Tìm tất cả các BillDetail liên quan đến thuốc này
                    int totalQuantitySold = billDetailRepository.findByMedicineName(medicine.getName()).stream()
                            .mapToInt(BillDetail::getQuantity) // Lấy quantity từ mỗi BillDetail
                            .sum(); // Cộng dồn để tính tổng số lượng bán ra

                    // Trả về cặp (MedicineForUserModel, totalQuantitySold) để dùng trong sắp xếp
                    return Map.entry(medicine, totalQuantitySold);
                })
                .sorted((entry1, entry2) -> Integer.compare(entry2.getValue(), entry1.getValue())) // Sắp xếp theo tổng số lượng giảm dần
                .limit(9) // Lấy top 10 sản phẩm
                .map(Map.Entry::getKey) // Chỉ lấy phần `MedicineForUserModel`
                .toList();
    }

    @Override
    public List<Map<String, Object>> findTop9FavoriteBrandsWithDetails() {
        // Lấy toàn bộ danh sách thuốc từ database
        List<Medicine> medicines = medicineRepository.findAll();

        // Nhóm theo tên thương hiệu, tính tổng số lượng sản phẩm và tổng số lượng bán ra
        Map<String, Map<String, Object>> manufacturerDetails = medicines.stream()
                .collect(Collectors.groupingBy(
                        medicine -> medicine.getManufacturer().getName(), // Nhóm theo tên thương hiệu (String)
                        Collectors.collectingAndThen(
                                Collectors.toList(),
                                brandMedicines -> {
                                    int totalProducts = brandMedicines.size(); // Số lượng sản phẩm của thương hiệu
                                    int totalSales = brandMedicines.stream()
                                            .mapToInt(medicine -> billDetailRepository.findByMedicineId(medicine.getId()).stream()
                                                    .mapToInt(BillDetail::getQuantity) // Lấy quantity từ mỗi BillDetail
                                                    .sum())
                                            .sum(); // Cộng dồn tổng số lượng bán ra

                                    // Tạo thông tin chi tiết thương hiệu
                                    Map<String, Object> details = new HashMap<>();
                                    details.put("brandName", brandMedicines.get(0).getManufacturer().getName());
                                    details.put("totalProducts", totalProducts);
                                    details.put("totalSales", totalSales);
                                    return details;
                                }
                        )
                ));

        // Chuyển Map thành List, sắp xếp giảm dần theo tổng số lượng bán ra và lấy top 9
        return manufacturerDetails.values().stream()
                .sorted((details1, details2) -> Integer.compare((int) details2.get("totalSales"), (int) details1.get("totalSales")))
                .limit(9) // Lấy top 9 thương hiệu
                .toList();
    }

    @Override
    public List<Map<String, Object>> findTop9FavoriteCategoriesWithDetails() {
        // Lấy toàn bộ danh sách thuốc từ database
        List<Medicine> medicines = medicineRepository.findAll();

        // Nhóm theo tên danh mục, tính tổng số lượng sản phẩm và tổng số lượng bán ra
        Map<String, Map<String, Object>> categoryDetails = medicines.stream()
                .collect(Collectors.groupingBy(
                        medicine -> medicine.getCategory().getName(), // Nhóm theo tên danh mục (String)
                        Collectors.collectingAndThen(
                                Collectors.toList(),
                                categoryMedicines -> {
                                    int totalProducts = categoryMedicines.size(); // Số lượng sản phẩm trong danh mục
                                    int totalSales = categoryMedicines.stream()
                                            .mapToInt(medicine -> billDetailRepository.findByMedicineId(medicine.getId()).stream()
                                                    .mapToInt(BillDetail::getQuantity) // Lấy quantity từ mỗi BillDetail
                                                    .sum())
                                            .sum(); // Cộng dồn tổng số lượng bán ra

                                    // Tạo thông tin chi tiết danh mục
                                    Map<String, Object> details = new HashMap<>();
                                    details.put("categoryName", categoryMedicines.get(0).getCategory().getName());
                                    details.put("totalProducts", totalProducts);
                                    details.put("totalSales", totalSales);
                                    return details;
                                }
                        )
                ));

        // Chuyển Map thành List, sắp xếp giảm dần theo tổng số lượng bán ra và lấy top 9
        return categoryDetails.values().stream()
                .sorted((details1, details2) -> Integer.compare((int) details2.get("totalSales"), (int) details1.get("totalSales")))
                .limit(9) // Lấy top 10 danh mục
                .toList();
    }

    @Override
    public List<Map<String, Object>> findTop3PopularMedicinesLast7Days() {
        // Lấy ngày hiện tại và 7 ngày trước
        java.sql.Date now = new java.sql.Date(System.currentTimeMillis());
        java.sql.Date sevenDaysAgo = new java.sql.Date(System.currentTimeMillis() - 7 * 24 * 60 * 60 * 1000);

        // Lấy danh sách BillDetail trong 7 ngày gần đây
        List<BillDetail> recentBillDetails = billDetailRepository.findAllByBillDateBetween(sevenDaysAgo, now);

        // Tính tổng số lượng bán ra cho mỗi sản phẩm
        Map<String, Integer> medicineSales = recentBillDetails.stream()
                .collect(Collectors.groupingBy(
                        billDetail -> billDetail.getMedicine().getId(), // Nhóm theo ID thuốc
                        Collectors.summingInt(BillDetail::getQuantity)  // Tổng số lượng bán ra
                ));

        // Sắp xếp các sản phẩm theo tổng số lượng bán được giảm dần và lấy top 5
        List<String> topMedicineIds = medicineSales.entrySet().stream()
                .sorted((entry1, entry2) -> Integer.compare(entry2.getValue(), entry1.getValue()))
                .limit(3) // Lấy top 3 sản phẩm
                .map(Map.Entry::getKey) // Lấy ID của sản phẩm
                .toList();

        // Lấy thông tin chi tiết của các sản phẩm dựa trên danh sách ID và thêm `totalSales`
        return topMedicineIds.stream()
                .map(medicineId -> {
                    Medicine medicine = medicineRepository.findById(medicineId)
                            .orElseThrow(() -> new RuntimeException("Medicine not found with ID: " + medicineId));
                    Map<String, Object> medicineDetails = new HashMap<>();
                    medicineDetails.put("id", medicine.getId());
                    medicineDetails.put("name", medicine.getName());
                    medicineDetails.put("description", medicine.getDescription());
                    medicineDetails.put("unitCost", medicine.getUnitCost());
                    medicineDetails.put("stockQuantity", medicine.getStockQuantity());
                    medicineDetails.put("dosage", medicine.getDosage());
                    medicineDetails.put("rating", medicine.getRating());
                    medicineDetails.put("manufacturerName", medicine.getManufacturer().getName());
                    medicineDetails.put("categoryName", medicine.getCategory().getName());
                    medicineDetails.put("unitName", medicine.getUnit().getName());
                    medicineDetails.put("expiryDate", medicine.getExpiryDate());
                    medicineDetails.put("image", medicine.getImage());
                    medicineDetails.put("totalSales", medicineSales.get(medicineId)); // Thêm tổng số lượt bán
                    return medicineDetails;
                })
                .toList();
    }

    @Override
    public List<MedicineForUserModel> getRelatedProducts(String id, String cateName, Pageable pageable) {
        Optional<MedicineForUserModel> medicine = findMedicineByIdForUser(id);
        Page<MedicineForUserModel> medicines_relative = searchMedicineByKeywordForUser(medicine.get().getCategoryName(), pageable);
        List<MedicineForUserModel> list = medicines_relative.getContent();
        return list;
    }

    @Override
    public Map<String, Object> parseDescription(String description, String medicineName) {
        Map<String, Object> sections = new LinkedHashMap<>(); // Duy trì thứ tự các phần
        String[] headers = {
                "Mô tả sản phẩm",
                "Thành phần",
                "Công dụng",
                "Cách dùng",
                "Tác dụng phụ",
                "Lưu ý",
                "Bảo quản"
        };

        // Tìm tiêu đề và nội dung
        String regex = "(" + String.join("|", headers) + ")";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(description);

        int lastIndex = 0;
        String lastHeader = null;

        while (matcher.find()) {
            if (lastHeader != null) {
                // Tách nội dung giữa các tiêu đề
                String sectionContent = description.substring(lastIndex, matcher.start()).trim();
                if (lastHeader.equals("Thành phần")) {
                    List<Map<String, String>> ingredients = parseIngredients(sectionContent);
                    sections.put(lastHeader, ingredients);
                } else {
                    sectionContent = removeMedicineName(sectionContent, medicineName);
                    sectionContent = capitalizeFirstLetter(sectionContent);
                    sections.put(lastHeader, sectionContent);
                }
            }

            // Cập nhật tiêu đề và vị trí
            lastHeader = matcher.group();
            lastIndex = matcher.end();
        }

        // Xử lý nội dung sau tiêu đề cuối cùng
        if (lastHeader != null && lastIndex < description.length()) {
            String sectionContent = description.substring(lastIndex).trim();
            if (lastHeader.equals("Thành phần")) {
                List<Map<String, String>> ingredients = parseIngredients(sectionContent);
                sections.put(lastHeader, ingredients);
            } else {
                sectionContent = removeMedicineName(sectionContent, medicineName);
                sectionContent = capitalizeFirstLetter(sectionContent);
                sections.put(lastHeader, sectionContent);
            }
        }

        return sections;
    }

    /**
     * Phân tích phần "Thành phần" để trích xuất thông tin thành phần và hàm lượng.
     */
    private List<Map<String, String>> parseIngredients(String content) {
        List<Map<String, String>> ingredients = new ArrayList<>();

        // Loại bỏ các từ và phần không cần thiết
        content = content.replaceAll("(?i)Thành phần của .+|Thành phần cho .+|Thông tin thành phần", "").trim();

        // Chia nội dung thành các dòng
        String[] lines = content.split("\n");

        // Duyệt qua từng dòng để tách thành phần và hàm lượng
        String ingredient = null;
        String quantity = null;

        for (String line : lines) {
            line = line.trim();

            if (line.isEmpty()) continue; // Bỏ qua các dòng trống

            // Kiểm tra nếu dòng này là thành phần hoặc hàm lượng
            if (ingredient == null) {
                // Dòng đầu tiên là thành phần
                ingredient = line;
            } else {
                // Dòng thứ hai là hàm lượng
                quantity = line;

                // Tạo bản đồ để lưu thành phần và hàm lượng
                Map<String, String> ingredientMap = new HashMap<>();
                ingredientMap.put("Thông tin thành phần", ingredient);
                ingredientMap.put("Hàm lượng", quantity);

                ingredients.add(ingredientMap);

                // Reset ingredient và quantity để chuẩn bị cho lần phân tích tiếp theo
                ingredient = null;
                quantity = null;
            }
        }

        return ingredients;
    }

    /**
     * Loại bỏ tên thuốc khỏi nội dung.
     */
    private String removeMedicineName(String content, String medicineName) {
        // Tách tên thuốc thành từng từ
        String[] nameParts = medicineName.split("\\s+");
        String normalizedContent = content;

        for (String part : nameParts) {
            if (part.length() > 1) { // Chỉ xử lý những từ dài hơn 1 ký tự
                String regex = "\\b" + Pattern.quote(part) + "\\b"; // Xóa từ chính xác
                normalizedContent = normalizedContent.replaceAll(regex, "").trim();
            }
        }

        return normalizedContent;
    }


    /**
     * Viết hoa chữ cái đầu.
     */
    private String capitalizeFirstLetter(String text) {
        if (text == null || text.isEmpty()) {
            return text;
        }
        return text.substring(0, 1).toUpperCase() + text.substring(1);
    }



}
