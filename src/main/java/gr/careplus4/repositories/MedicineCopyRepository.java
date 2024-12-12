package gr.careplus4.repositories;

import gr.careplus4.entities.MedicineCopy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MedicineCopyRepository extends JpaRepository<MedicineCopy, Long> {
    MedicineCopy findMedicineCopyByBillDetail_Id(long billDetailId);

    MedicineCopy findMedicineCopyById(long id);
}
