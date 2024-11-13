package gr.careplus4.services;

import gr.careplus4.entities.Manufacturer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface iManufacturerServices {
    List<Manufacturer> findByNameContaining(String name);

    Page<Manufacturer> findByNameContaining(String name, Pageable pageable);

    List<Manufacturer> findAll();

    <S extends Manufacturer> S save(S entity);

    Optional<Manufacturer> findById(String s);

    long count();

    void deleteById(String s);

    Page<Manufacturer> findAll(Pageable pageable);

    Optional<Manufacturer> findByName(String name);

    Manufacturer findTopByOrderByIdDesc();

    Boolean existsByName(String name);

    String generateManufacturerId(String previousId);
}
