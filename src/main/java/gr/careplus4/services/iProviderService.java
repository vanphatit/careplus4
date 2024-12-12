package gr.careplus4.services;

import gr.careplus4.entities.Provider;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface iProviderService {
    Page<Provider> findAll(Pageable pageable);
    List<Provider> findAll();
    Page<Provider> findByNameContaining(String name, Pageable pageable);
    <S extends Provider> S save(S entity);
    void deleteById(String id);
    Optional<Provider> findById(String id);
    Optional<Provider> findByName(String name);
    Provider findTopByOrderByIdDesc ();
    Boolean existsById(String id);
    Boolean existsByName(String name);
    String generateProviderId(String previousId);
    Page<Provider> findByIdContaining(String id, Pageable pageable);
    boolean checkUsed(String id);
}
