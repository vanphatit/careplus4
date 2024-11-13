package gr.careplus4.services.impl;

import gr.careplus4.entities.Manufacturer;
import gr.careplus4.repositories.ManufacturerRepository;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.iManufacturerServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ManufacturerServicesImpl implements iManufacturerServices {
    @Autowired
    ManufacturerRepository manufacturerRepository;

    @Override
    public List<Manufacturer> findByNameContaining(String name) {
        return manufacturerRepository.findByNameContaining(name);
    }

    @Override
    public Page<Manufacturer> findByNameContaining(String name, Pageable pageable) {
        return manufacturerRepository.findByNameContaining(name, pageable);
    }

    @Override
    public List<Manufacturer> findAll() {
        return manufacturerRepository.findAll();
    }

    @Override
    public <S extends Manufacturer> S save(S entity) {
        if (entity.getId() == null) {
            Manufacturer lastManufacturer = findTopByOrderByIdDesc();
            String previousManufacturerId = (lastManufacturer != null) ? lastManufacturer.getId() : "MAN0000";
            entity.setId(generateManufacturerId(previousManufacturerId));
        }
        return manufacturerRepository.save(entity);
    }

    @Override
    public Optional<Manufacturer> findById(String s) {
        return manufacturerRepository.findById(s);
    }

    @Override
    public long count() {
        return manufacturerRepository.count();
    }

    @Override
    public void deleteById(String s) {
        manufacturerRepository.deleteById(s);
    }

    @Override
    public Page<Manufacturer> findAll(Pageable pageable) {
        return manufacturerRepository.findAll(pageable);
    }

    @Override
    public Optional<Manufacturer> findByName(String name) {
        return (manufacturerRepository.findByName(name));
    }

    @Override
    public Manufacturer findTopByOrderByIdDesc() {
        return manufacturerRepository.findTopByOrderByIdDesc();
    }

    @Override
    public Boolean existsByName(String name) {
        return manufacturerRepository.existsByName(name);
    }

    @Override
    public String generateManufacturerId(String previousId) {
        return GeneratedId.getGeneratedId(previousId);
    }
}
