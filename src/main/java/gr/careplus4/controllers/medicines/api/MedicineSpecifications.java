package gr.careplus4.controllers.medicines.api;

import gr.careplus4.entities.Medicine;
import org.springframework.data.jpa.domain.Specification;

import java.util.Map;

public class MedicineSpecifications {
    public static Specification<Medicine> hasAttributes(Map<String, Object> attributes) {
        return (root, query, criteriaBuilder) -> {
            var predicate = criteriaBuilder.conjunction();
            attributes.forEach((key, value) -> {
                if (value != null) {
                    predicate.getExpressions().add(criteriaBuilder.equal(root.get(key), value));
                }
            });
            return predicate;
        };
    }
}
