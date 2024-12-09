package gr.careplus4.repositories;

import gr.careplus4.entities.BillDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface BillDetailRepository extends JpaRepository<BillDetail, Long> {
    List<BillDetail> findByMedicineName(String medicineName);
    List<BillDetail> findByMedicineId(String medicineId);
    List<BillDetail> findAllByBillDateBetween(Date startDate, Date endDate);
    Boolean existsByMedicineId(String medicineId);
}
