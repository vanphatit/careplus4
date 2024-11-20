package gr.careplus4.repositories;

import gr.careplus4.entities.Bill;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BillRepository extends JpaRepository<Bill, String> {
}
