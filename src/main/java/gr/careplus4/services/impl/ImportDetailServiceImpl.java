package gr.careplus4.services.impl;

import gr.careplus4.entities.ImportDetail;
import gr.careplus4.repositories.ImportDetailRepository;
import gr.careplus4.services.iImportDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ImportDetailServiceImpl implements iImportDetailService {
    @Autowired
    ImportDetailRepository importDetailRepository;

    @Override
    public Boolean existsImportDetailById(Long id) {
        return importDetailRepository.existsById(id);
    }

    @Override
    public Boolean existsImportDetailByImportId(String importId) {
        return importDetailRepository.existsByImportRecord_Id(importId);
    }

    @Override
    public Boolean existsImportDetailByMedicineId(String medicineId) {
        return importDetailRepository.existsByMedicine_Id(medicineId);
    }

    @Override
    public Long countByImportId(String importId) {
        return importDetailRepository.countByImportRecord_Id(importId);
    }

    @Override
    public Long countByMedicineId(String medicineId) {
        return importDetailRepository.countByMedicine_Id(medicineId);
    }

    @Override
    public Optional<ImportDetail> findImportDetailById(Long id) {
        return importDetailRepository.findById(id);
    }

    @Override
    public Optional<ImportDetail> findImportDetailByImportId(String importId) {
        return importDetailRepository.findByImportRecord_Id(importId);
    }

    @Override
    public Optional<ImportDetail> findImportDetailByMedicineId(String medicineId) {
        return importDetailRepository.findByMedicine_Id(medicineId);
    }
}

