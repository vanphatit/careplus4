package gr.careplus4.services.specification;

import gr.careplus4.entities.Bill;
import org.springframework.data.jpa.domain.Specification;

public class BillSpecification {
    public static Specification<Bill> statusEquals(String status) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("status"), status);
    }
}
