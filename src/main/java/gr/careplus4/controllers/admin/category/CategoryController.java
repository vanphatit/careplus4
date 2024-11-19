package gr.careplus4.controllers.admin.category;

import gr.careplus4.entities.Category;
import gr.careplus4.models.CategoryModel;
import gr.careplus4.repositories.CategoryRepository;
import gr.careplus4.services.impl.CategoryServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class CategoryController {

    @Autowired
    private CategoryServiceImpl categoryService;

    @Autowired
    private CategoryRepository categoryRepository;

    @GetMapping("/categories")
    public String getCategories(Model model, @RequestParam(defaultValue = "1") int page) {
        int pageSize = 5;
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        Page<Category> prs = this.categoryService.fetchAllCategories(pageable);
        List<Category> categories = prs.getContent();
        int numberPages = this.categoryService.getNumberOfPage(pageSize);
        model.addAttribute("categories", categories);
        model.addAttribute("pageNo", numberPages);
        model.addAttribute("currentPage", page);

        return "admin/category/category-list";
    }

    @GetMapping("/category/create")
    public String getCreateCategoryPage(Model model) {
        List<Category> categories = categoryService.findAll();
        model.addAttribute("newCategory", new CategoryModel());
        model.addAttribute("categories", categories);
        return "admin/category/create";
    }

    @PostMapping("/category/create")
    public String handleCreateProduct(
            @ModelAttribute("newCategory") @Valid CategoryModel category,
            BindingResult newProductBindingResult) {
        // validate
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/create";
        }

        this.categoryService.save(category);

        return "redirect:/admin/categories";
    }

    @GetMapping("/category/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable String id) {
        Optional<Category> currentCategory = this.categoryService.findById(id);
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);
        model.addAttribute("currentCategory", currentCategory.get());
        return "admin/category/update";
    }

    @PostMapping("category/update")
    public String handleUpdateProduct(
            @ModelAttribute("newCategory") @Valid CategoryModel category,
            BindingResult newProductBindingResult) {

        // // validate
        if (newProductBindingResult.hasErrors()) {
            return "admin/category/update";
        }

        CategoryModel newCategory = new CategoryModel();
        newCategory.setId(category.getId());
        newCategory.setName(category.getName());
        newCategory.setStatus(category.getStatus());
        newCategory.setParentCategoryId(category.getParentCategoryId());
        this.categoryService.save(newCategory);

        return "redirect:/admin/categories";
    }

    @GetMapping("/category/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable String id) {
        Optional<Category> category = this.categoryService.findById(id);
        this.categoryService.delete(category.get());
        return "redirect:/admin/categories";
    }

    @GetMapping("/category/{id}")
    public String getProductDetailPage(Model model, @PathVariable String id) {
        Optional<Category> category = this.categoryService.findById(id);
        model.addAttribute("category", category.get());
        return "admin/category/detail";
    }
}
