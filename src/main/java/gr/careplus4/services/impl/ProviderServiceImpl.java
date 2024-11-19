package gr.careplus4.services.impl;

import gr.careplus4.entities.Manufacturer;
import gr.careplus4.entities.Provider;
import gr.careplus4.repositories.ProviderRepository;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.iProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProviderServiceImpl implements iProviderService {

    @Autowired
    ProviderRepository providerRepository;

    @Override
    public Page<Provider> findAll(Pageable pageable) {
        return providerRepository.findAll(pageable);
    }

    @Override
    public List<Provider> findAll() {
        return providerRepository.findAll();
    }

    @Override
    public Page<Provider> findByNameContaining(String name, Pageable pageable) {
        return providerRepository.findByNameContaining(name, pageable);
    }

    @Override
    public <S extends Provider> S save(S entity) {
        if (entity.getId() == null || entity.getId().trim().isEmpty()) //Loại bỏ mọi khoảng trắng ở đầu và cuối chuỗi id.
        {
            Provider lastProvider = findTopByOrderByIdDesc();
            String previousProviderId = (lastProvider != null) ? lastProvider.getId() : "PRO0001";
            entity.setId(generateProviderId(previousProviderId));
        }
        return providerRepository.save(entity);
    }

    @Override
    public void deleteById(String id) {
        providerRepository.deleteById(id);
    }

    @Override
    public Optional<Provider> findById(String id) {
        return providerRepository.findById(id);
    }


    @Override
    public Optional<Provider> findByName(String name) {
        return providerRepository.findByName(name);
    }

    @Override
    public Provider findTopByOrderByIdDesc() {
        return providerRepository.findTopByOrderByIdDesc();
    }

    @Override
    public Boolean existsById(String id) {
        return providerRepository.existsById(id);
    }

    @Override
    public Boolean existsByName(String name) {
        return providerRepository.existsByName(name);
    }

    @Override
    public String generateProviderId(String previousId) {
        return GeneratedId.getGeneratedId(previousId);
    }

    @Override
    public Page<Provider> findByIdContaining(String id, Pageable pageable) {
        return providerRepository.findByIdContaining(id, pageable);
    }
}
