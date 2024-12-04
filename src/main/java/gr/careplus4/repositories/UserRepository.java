package gr.careplus4.repositories;

import gr.careplus4.entities.User;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findByName(String name);
    Page<User> findByNameContaining(String name, Pageable pageable);

    Page<User> findByNameContainingIgnoreCaseOrPhoneNumber(String name, String phoneNumber, Pageable pageable);
    Page<User> findByRoleName(String roleName, Pageable pageable);
    Optional<User> findByEmail(String email);
    boolean existsByEmail(String email);
    Optional<User> findByPhoneNumber(String phoneNumber);

}
