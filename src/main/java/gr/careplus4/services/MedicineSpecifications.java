package gr.careplus4.services;

import gr.careplus4.entities.Medicine;
import gr.careplus4.models.MedicineForUserModel;
import jakarta.persistence.criteria.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class MedicineSpecifications {
    public static Specification<Medicine> containsKeywordInAttributes(String keyword) {
        return (root, query, criteriaBuilder) -> {
            String likePattern = "%" + keyword.toLowerCase() + "%";

            // Tìm kiếm trong thuộc tính name của Medicine
            var medicineNamePredicate = criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), likePattern);

            // Tìm kiếm trong thuộc tính name của Category
            var categoryNamePredicate = criteriaBuilder.like(criteriaBuilder.lower(root.join("category").get("name")), likePattern);

            // Tìm kiếm trong thuộc tính name của Manufacturer
            var manufacturerNamePredicate = criteriaBuilder.like(criteriaBuilder.lower(root.join("manufacturer").get("name")), likePattern);

            // Tìm kiếm theo thuộc tính description của Medicine
            var descriptionPredicate = criteriaBuilder.like(criteriaBuilder.lower(root.get("description")), likePattern);

            // Tìm kiếm theo thuộc tính name của Unit
            var unitNamePredicate = criteriaBuilder.like(criteriaBuilder.lower(root.join("unit").get("name")), likePattern);

            // Tìm kiếm theo thuộc tính dosage của Medicine
            var dosagePredicate = criteriaBuilder.like(criteriaBuilder.lower(root.get("dosage")), likePattern);

            // Kết hợp tất cả điều kiện với OR
            return criteriaBuilder.or(medicineNamePredicate, categoryNamePredicate, manufacturerNamePredicate, descriptionPredicate, unitNamePredicate, dosagePredicate);
        };
    }

    public static Specification<Medicine> buildSpecification(
            String manufacturerName, String categoryName, String unitName,
            BigDecimal unitCostMin, BigDecimal unitCostMax,
            Date expiryDateMin, Date expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax,
            Date importDateMin, Date importDateMax
    ) {
        return (root, query, criteriaBuilder) -> {
            Predicate predicate = criteriaBuilder.conjunction();

            // Manufacturer filter
            if (manufacturerName != null) {
                Join<Object, Object> manufacturerJoin = root.join("manufacturer", JoinType.LEFT);
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.equal(manufacturerJoin.get("name"), manufacturerName));
            }

            // Category filter
            if (categoryName != null) {
                Join<Object, Object> categoryJoin = root.join("category", JoinType.LEFT);
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.equal(categoryJoin.get("name"), categoryName));
            }

            // Unit filter
            if (unitName != null) {
                Join<Object, Object> unitJoin = root.join("unit", JoinType.LEFT);
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.equal(unitJoin.get("name"), unitName));
            }

            // Unit Cost filter
            if (unitCostMin != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.greaterThanOrEqualTo(root.get("unitCost"), unitCostMin));
            }
            if (unitCostMax != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.lessThanOrEqualTo(root.get("unitCost"), unitCostMax));
            }

            // Stock Quantity filter
            if (stockQuantityMin != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.greaterThanOrEqualTo(root.get("stockQuantity"), stockQuantityMin));
            }
            if (stockQuantityMax != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.lessThanOrEqualTo(root.get("stockQuantity"), stockQuantityMax));
            }

            // Rating filter
            if (ratingMin != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.greaterThanOrEqualTo(root.get("rating"), ratingMin));
            }
            if (ratingMax != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.lessThanOrEqualTo(root.get("rating"), ratingMax));
            }

            // Expiry Date filter
            if (expiryDateMin != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.greaterThanOrEqualTo(root.get("expiryDate"), expiryDateMin));
            }
            if (expiryDateMax != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.lessThanOrEqualTo(root.get("expiryDate"), expiryDateMax));
            }

            // Import Date filter
            if (importDateMin != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.greaterThanOrEqualTo(root.get("importDate"), importDateMin));
            }
            if (importDateMax != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.lessThanOrEqualTo(root.get("importDate"), importDateMax));
            }


            return predicate;
        };
    }
}
