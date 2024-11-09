package gr.careplus4.services;

import gr.careplus4.entities.Role;

import java.util.List;
import java.util.Optional;

public interface iRoleService {
    List<Role> findAll();

    <S extends Role> S save(S entity);

    Optional<Role> findById(Integer integer);

    boolean existsById(Integer integer);

    long count();

    void deleteById(Integer integer);

    void delete(Role entity);

    void deleteAll();
}
