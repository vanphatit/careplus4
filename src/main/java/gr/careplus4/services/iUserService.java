package gr.careplus4.services;

import gr.careplus4.entities.User;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface iUserService {

    boolean emailExists(String email);

    Optional<User> findByPhoneNumber(String phone);

    void delete(User entity);

    <S extends User> List<S> findAll(Example<S> example);

    <S extends User> Page<S> findAll(Example<S> example, Pageable pageable);

    Page<User> findUsersByStatusAndRole_Name(boolean status, String roleName, Pageable pageable);

    Page<User> findUsersByRole_Name(String roleName, Pageable pageable);

    long count();

    <S extends User> List<S> saveAll(Iterable<S> entities);

    Optional<User> findByName(String name);

    Page<User> findByNameContaining(String name, Pageable pageable);

    Page<User> findUsersByStatus(boolean status, Pageable pageable);

    Page<User> findByNameContainingIgnoreCaseOrPhoneNumber(String name, String phoneNumber, Pageable pageable);

    Optional<User> findByEmail(String email);

    List<User> findAll();

    <S extends User> S save(S entity);

    void deleteAll();

    Page<User> findAll(Pageable pageable);

    int countUsersWithRoleUserIsActive();
}
