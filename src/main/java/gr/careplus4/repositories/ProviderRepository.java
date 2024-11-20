package gr.careplus4.repositories;

import gr.careplus4.entities.Provider;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProviderRepository extends JpaRepository<Provider, String> {
    List<Provider> findByNameContaining (String name);
    Page<Provider> findByNameContaining (String name, Pageable pageable);
    Optional<Provider> findById(String id);
    Page<Provider> findByIdContaining (String id, Pageable pageable);
    Optional<Provider> findByName(String name);
    Page<Provider> findAll (Pageable pageable);
    boolean existsById(String id);
    boolean existsByName(String name);
    Provider findTopByOrderByIdDesc();
}
