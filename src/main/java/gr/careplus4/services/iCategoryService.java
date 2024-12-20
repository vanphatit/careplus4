package gr.careplus4.services;

import gr.careplus4.entities.Category;
import gr.careplus4.models.CategoryModel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface iCategoryService {
    List<Category> findAll();
    Page<Category> fetchAllCategories(Pageable page);
    @Query("SELECT c FROM Category c LEFT JOIN FETCH c.subCategories WHERE c.parentCategory IS NULL")
    List<Category> findRootCategoriesWithSubCategories();
    Optional<Category> findById(String id);
    Category save(CategoryModel categoryModel);
    void delete(Category category);
    Optional<Category> findByCategoryName(String name);
    boolean existsById (String id);
    boolean existsByName(String name);
    int getNumberOfPage(int pageSize);
    Page<Category> findAll(Pageable pageable);
    Page<Category> findByNameLike(String name, Pageable pageable);

    List<Category> findAllSubCategories();
}