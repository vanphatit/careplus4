package gr.careplus4.services.impl;

import gr.careplus4.entities.ImportDetail;
import gr.careplus4.entities.Medicine;
import gr.careplus4.repositories.*;
import gr.careplus4.services.iImportDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ImportDetailServiceImpl implements iImportDetailService {
    @Autowired
    ImportDetailRepository importDetailRepository;

    @Autowired
    MedicineRepository medicineRepository;

    @Autowired
    BillDetailRepository billDetailRepository;

    @Autowired
    ReviewDetailRepository reviewDetailRepository;

    @Autowired
    CartDetailRepository cartDetailRepository;

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
    public List<ImportDetail> findImportDetailByImportId(String importId) {
        return importDetailRepository.findByImportRecord_Id(importId);
    }

    @Override
    public Optional<ImportDetail> findImportDetailByMedicineId(String medicineId) {
        return importDetailRepository.findByMedicine_Id(medicineId);
    }

    @Transactional
    @Override
    public void deleteByImportId(String importId) {
        importDetailRepository.deleteByImportRecord_Id(importId);
    }

    @Override
    public void deleteById(Long id) {
        importDetailRepository.deleteById(id);
    }

    @Override
    public Optional<ImportDetail> findById(Long id) {
        return importDetailRepository.findById(id);
    }

    @Override
    public ImportDetail save(ImportDetail importDetail) {
        return importDetailRepository.save(importDetail);
    }

    @Override
    public boolean checkDelete(Long id) {
       Optional<ImportDetail> importDetailOptional = importDetailRepository.findById(id);
       Optional<Medicine> medicineOptional = medicineRepository.findById(importDetailOptional.get().getMedicine().getId());
       if (medicineOptional.get().getStockQuantity() <= importDetailOptional.get().getQuantity() ) {
           return true;
       }
       return false;
    }

    @Override
    public boolean checkMedicineInBillOrReviewOrCart(String id) {
        if (billDetailRepository.existsByMedicineId(id) || reviewDetailRepository.existsReviewDetailByMedicine_Id(id) || cartDetailRepository.existsByMedicine_Id(id)) {
            return true;
        }
        return false;
    }

}

