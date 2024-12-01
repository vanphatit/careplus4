package gr.careplus4.repositories;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.Import;
import gr.careplus4.entities.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface BillRepository extends JpaRepository<Bill, String> {
    List<Bill> findBillsByUser(User user);
    Page<Bill> findAllBillsByUser(User user, Pageable pageable);
    @Query("SELECT b FROM Bill b WHERE b.id = :id")
    Page<Bill> findByIdContaining(@Param("id") String id, Pageable pageable);
    Page<Bill> findAll(Pageable pageable);

    List<Bill> findBillsByDate(Date date);
    List<Bill> findBillsByDate(Date date, Pageable pageable);
}
