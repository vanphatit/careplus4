package gr.careplus4.repositories;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.User;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface BillRepository extends JpaRepository<Bill, String> {
    List<Bill> findBillsByUser(User user);
    List<Bill> findBillsByUser(User user, Pageable pageable);

    List<Bill> findBillsByDate(Date date);
    List<Bill> findBillsByDate(Date date, Pageable pageable);
}
