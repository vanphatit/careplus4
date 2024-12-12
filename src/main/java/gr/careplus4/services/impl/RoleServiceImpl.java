package gr.careplus4.services.impl;

import gr.careplus4.entities.Role;
import gr.careplus4.repositories.RoleRepository;
import gr.careplus4.services.iRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoleServiceImpl implements iRoleService {
    @Autowired
    private RoleRepository roleRepository;

    @Override
    public List<Role> findAll() {
        return roleRepository.findAll();
    }

    @Override
    public <S extends Role> S save(S entity) {
        return roleRepository.save(entity);
    }

    @Override
    public Optional<Role> findById(Integer integer) {
        return roleRepository.findById(integer);
    }

    @Override
    public Optional<Role> findByName(String name) {
        return roleRepository.findByName(name);
    }

    @Override
    public boolean existsById(Integer integer) {
        return roleRepository.existsById(integer);
    }

    @Override
    public long count() {
        return roleRepository.count();
    }

    @Override
    public void deleteById(Integer integer) {
        roleRepository.deleteById(integer);
    }

    @Override
    public void delete(Role entity) {
        roleRepository.delete(entity);
    }

    @Override
    public void deleteAll() {
        roleRepository.deleteAll();
    }
}
