package gr.careplus4.controllers.medicines.api;

import gr.careplus4.entities.Medicine;
import org.springframework.data.jpa.domain.Specification;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Map;

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

            // Kết hợp tất cả điều kiện với OR
            return criteriaBuilder.or(medicineNamePredicate, categoryNamePredicate, manufacturerNamePredicate, descriptionPredicate);
        };
    }

    public static Specification<Medicine> buildSpecification (
            String manufacturerName, String categoryName, String unitName,
            BigDecimal unitCostMin, BigDecimal unitCostMax,
            Long expiryDateMin, Long expiryDateMax,
            Integer stockQuantityMin, Integer stockQuantityMax,
            BigDecimal ratingMin, BigDecimal ratingMax
    ) {
        return (root, query, criteriaBuilder) -> {
            var predicate = criteriaBuilder.conjunction();

            if (manufacturerName != null) {
                predicate.getExpressions().add(criteriaBuilder.equal(root.join("manufacturer").get("name"), manufacturerName));
            }

            if (categoryName != null) {
                predicate.getExpressions().add(criteriaBuilder.equal(root.join("category").get("name"), categoryName));
            }

            if (unitName != null) {
                predicate.getExpressions().add(criteriaBuilder.equal(root.join("unit").get("name"), unitName));
            }

            if (unitCostMin != null && unitCostMax != null) {
                predicate.getExpressions().add(criteriaBuilder.between(root.get("unitCost"), unitCostMin, unitCostMax));
            }

            if (expiryDateMin != null && expiryDateMax != null) {
                predicate.getExpressions().add(criteriaBuilder.between(root.get("expiryDate"), new Date(expiryDateMin), new Date(expiryDateMax)));
            }

            if (stockQuantityMin != null && stockQuantityMax != null) {
                predicate.getExpressions().add(criteriaBuilder.between(root.get("stockQuantity"), stockQuantityMin, stockQuantityMax));
            }

            if (ratingMin != null && ratingMax != null) {
                predicate.getExpressions().add(criteriaBuilder.between(root.get("rating"), ratingMin, ratingMax));
            }

            return predicate;
        };
    }
}
