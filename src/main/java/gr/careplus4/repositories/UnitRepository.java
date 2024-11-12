package gr.careplus4.repositories;

import gr.careplus4.entities.Unit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UnitRepository extends JpaRepository<Unit, String> {
    Boolean existsUnitByName(String name);

    Optional<Unit> findByName(String name);
}
