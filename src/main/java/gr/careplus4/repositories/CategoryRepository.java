package gr.careplus4.repositories;

import gr.careplus4.entities.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<Category, String> {
    Page<Category> findAll(Pageable page);

    Optional<Category> findByNameLike(String name);

    boolean existsById(String id);

    boolean existsByName(String name);
}
