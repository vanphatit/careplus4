package gr.careplus4.repositories;

import gr.careplus4.entities.Bill;
import gr.careplus4.entities.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<Category, String> {
    Page<Category> findAll(Pageable page);

    @Query("SELECT c FROM Category c LEFT JOIN FETCH c.subCategories WHERE c.parentCategory IS NULL")
    List<Category> findRootCategoriesWithSubCategories();

    Optional<Category> findByNameLike(String name);

    boolean existsById(String id);

    boolean existsByName(String name);

    @Query("SELECT c FROM Category c WHERE c.name LIKE %:name%")
    Page<Category> findByNameLike(@Param("name") String name, Pageable pageable);
}
