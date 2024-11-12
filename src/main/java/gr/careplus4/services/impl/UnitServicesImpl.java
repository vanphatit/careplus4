package gr.careplus4.services.impl;

import gr.careplus4.entities.Unit;
import gr.careplus4.repositories.UnitRepository;
import gr.careplus4.services.iUnitServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UnitServicesImpl implements iUnitServices {
    @Autowired
    UnitRepository unitRepository;

    public UnitServicesImpl(UnitRepository unitRepository) {
        this.unitRepository = unitRepository;
    }

    @Override
    public Boolean existsUnitByName(String name) {
        return unitRepository.existsUnitByName(name);
    }

    @Override
    public List<Unit> findAll() {
        return unitRepository.findAll();
    }

    @Override
    public <S extends Unit> S save(S entity) {
        return unitRepository.save(entity);
    }

    @Override
    public Optional<Unit> findById(String s) {
        return unitRepository.findById(s);
    }

    @Override
    public long count() {
        return unitRepository.count();
    }

    @Override
    public void deleteById(String s) {
        unitRepository.deleteById(s);
    }

    @Override
    public Page<Unit> findAll(Pageable pageable) {
        return unitRepository.findAll(pageable);
    }

    @Override
    public Optional<Unit> findByName(String name) {
        return unitRepository.findByName(name);
    }
}
