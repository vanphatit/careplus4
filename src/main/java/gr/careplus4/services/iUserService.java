package gr.careplus4.services;

import gr.careplus4.entities.User;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface iUserService {

    boolean checkLogin(String phone, String password);

    boolean emailExists(String email);

    User createUser(User user);

    Optional<User> findByPhoneNumber(String phone);

    void delete(User entity);

    <S extends User> List<S> findAll(Example<S> example);

    <S extends User> Page<S> findAll(Example<S> example, Pageable pageable);

    long count();

    <S extends User> List<S> saveAll(Iterable<S> entities);

    Page<User> findByUserNameContaining(String name, Pageable pageable);

    List<User> findAll();

    <S extends User> S save(S entity);

    void deleteAll();

    Page<User> findAll(Pageable pageable);
}
