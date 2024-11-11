package gr.careplus4.services.impl;

import gr.careplus4.entities.Category;
import gr.careplus4.models.CategoryModel;
import gr.careplus4.repositories.CategoryRepository;
import gr.careplus4.services.iCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryServiceImpl implements iCategoryService {

    @Autowired
    CategoryRepository categoryRepository;

    public CategoryServiceImpl(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Override
    public Optional<Category> findById(String id) {
        return categoryRepository.findById(id);
    }

    @Override
    public Category save(CategoryModel categoryModel) {
        Category category = new Category();
        category.setId(categoryModel.getId());
        category.setName(categoryModel.getName());
        category.setStatus(categoryModel.getStatus());

        if (categoryModel.getParentCategoryId() != null &&
                this.findById(categoryModel.getParentCategoryId()).isPresent()) {
            Category pCategory = this.findById(categoryModel.getParentCategoryId()).get();
            category.setParentCategory(pCategory);
        }

        return categoryRepository.save(category);
    }

    @Override
    public void delete(Category category) {
        categoryRepository.delete(category);
    }

    @Override
    public Optional<Category> findByCategoryName(String name) {
        return categoryRepository.findByNameContaining(name);
    }

    @Override
    public boolean existsById(String id) {
        return categoryRepository.existsById(id);
    }

    @Override
    public boolean existsByName(String name) {
        return categoryRepository.existsByName(name);
    }
}
