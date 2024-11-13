package gr.careplus4.services;

import gr.careplus4.entities.Unit;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface iUnitServices {
    Boolean existsUnitByName(String name);

    List<Unit> findAll();

    <S extends Unit> S save(S entity);

    Optional<Unit> findById(String s);

    long count();

    void deleteById(String s);

    Page<Unit> findAll(Pageable pageable);

    Optional<Unit> findByName(String name);

    Unit findTopByOrderByIdDesc();

    List<Unit> findByNameContaining(String name);

    Page<Unit> findByNameContaining(String name, Pageable pageable);

    Boolean existsByName(String name);
}
