package gr.careplus4.repositories;

import gr.careplus4.entities.Manufacturer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ManufacturerRepository extends JpaRepository<Manufacturer, String> {
    List<Manufacturer> findByNameContaining(String name);
    Page<Manufacturer> findByNameContaining(String name, Pageable pageable);

    Boolean existsByName(String name);

    Optional<Manufacturer> findByName(String name);

    Manufacturer findTopByOrderByIdDesc();
}
