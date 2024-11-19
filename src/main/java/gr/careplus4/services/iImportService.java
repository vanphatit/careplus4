package gr.careplus4.services;

import gr.careplus4.entities.Import;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface iImportService {
    void deleteById (String id);
    List<Import> findAll ();
    Optional<Import> findById (String id);
    Page<Import> findById (String id, Pageable pageable);
    <S extends Import> S save (S entity);
    Page<Import> findAll (Pageable pageable);
    Page<Import> findByProviderId(String providerId, Pageable pageable);
}
