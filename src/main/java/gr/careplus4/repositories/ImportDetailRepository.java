package gr.careplus4.repositories;

import gr.careplus4.entities.ImportDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ImportDetailRepository extends JpaRepository<ImportDetail, Long> {
    boolean existsByImportRecord_Id(String importId); // Kiểm tra tồn tại bằng importRecord.id

    boolean existsByMedicine_Id(String medicineId);   // Kiểm tra tồn tại bằng medicine.id

    Long countByImportRecord_Id(String importId);     // Đếm theo importRecord.id

    Long countByMedicine_Id(String medicineId);       // Đếm theo medicine.id

    Optional<ImportDetail> findByImportRecord_Id(String importId); // Tìm ImportDetail bằng importRecord.id

    Optional<ImportDetail> findByMedicine_Id(String medicineId);   // Tìm ImportDetail bằng medicine.id


}
