package gr.careplus4.services.impl;

import gr.careplus4.entities.Import;
import gr.careplus4.repositories.ImportRepository;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.iImportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
@Service
public class ImportServiceImpl implements iImportService {

    @Autowired
    ImportRepository importRepository;

    @Override
    public void deleteById(String id) {
        importRepository.deleteById(id);
    }

    @Override
    public List<Import> findAll() {
        return importRepository.findAll();
    }

    @Override
    public Optional<Import> findById(String id) {
        return importRepository.findById(id);
    }

    @Override
    public Page<Import> findByIdContaining(String id, Pageable pageable) {
        return importRepository.findByIdContaining(id, pageable);
    }


    @Override
    public <S extends Import> S save(S entity) {
        if (entity.getId() == "") {
            // Lấy ID lớn nhất hiện có và tạo ID mới
            Import importWithMaxId = importRepository.findTopByOrderByIdDesc();
            String previousId = importWithMaxId != null ? importWithMaxId.getId() : "IM00000";
            entity.setId(GeneratedId.getGeneratedId(previousId));
            return importRepository.save(entity);
        }
        return importRepository.save(entity);
    }

    @Override
    public Page<Import> findAll(Pageable pageable) {
        return importRepository.findAll(pageable);
    }

    @Override
    public Page<Import> findByProviderIdContaining(String providerId, Pageable pageable) {
        return importRepository.findByProviderIdContaining(providerId, pageable);
    }

    @Override
    public Import findTopByOrderByIdDesc() {
        return importRepository.findTopByOrderByIdDesc();
    }

    @Override
    public void updateTotalAmount(String importId, BigDecimal subTotal) {
        Import importRecord = importRepository.findById(importId).get();
        BigDecimal totalAmount = importRecord.getTotalAmount();
        totalAmount = totalAmount.add(subTotal);
        importRecord.setTotalAmount(totalAmount);
        importRepository.save(importRecord);
    }
}
