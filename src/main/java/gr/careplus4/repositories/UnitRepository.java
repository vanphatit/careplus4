package gr.careplus4.repositories;

import gr.careplus4.entities.Unit;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UnitRepository extends JpaRepository<Unit, String> {
    List<Unit> findByNameContaining(String name);
    Page<Unit> findByNameContaining(String name, Pageable pageable);

    Boolean existsUnitByName(String name);

    Optional<Unit> findByName(String name);

    Unit findTopByOrderByIdDesc();

    Boolean existsByName(String name);
}
