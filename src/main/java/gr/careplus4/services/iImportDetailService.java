package gr.careplus4.services;

import gr.careplus4.entities.ImportDetail;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public interface iImportDetailService {
    Boolean existsImportDetailById(Long id);
    Boolean existsImportDetailByImportId(String importId);
    Boolean existsImportDetailByMedicineId(String medicineId);

    Long countByImportId(String importId);
    Long countByMedicineId(String medicineId);

    Optional<ImportDetail> findImportDetailById(Long id);
    Optional<ImportDetail> findImportDetailByImportId(String importId);
    Optional<ImportDetail> findImportDetailByMedicineId(String medicineId);

    void deleteByImportId(String importId);
}
