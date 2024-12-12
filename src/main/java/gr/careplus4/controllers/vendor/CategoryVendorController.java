package gr.careplus4.controllers.vendor;

import gr.careplus4.entities.Category;
import gr.careplus4.models.CategoryModel;
import gr.careplus4.services.impl.CategoryServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/vendor")
public class CategoryVendorController {

    @Autowired
    private CategoryServiceImpl categoryService;

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

        return "vendor/category/category-list";
    }

    @GetMapping("/category/create")
    public String getCreateCategoryPage(Model model) {
        List<Category> categories = categoryService.findAll();
        model.addAttribute("newCategory", new CategoryModel());
        model.addAttribute("categories", categories);
        return "vendor/category/create";
    }

    @PostMapping("/category/create")
    public String handleCreateProduct( Model model,
                                       @ModelAttribute("newCategory") @Valid CategoryModel category,
                                       BindingResult newProductBindingResult) {

        List<Category> categories = categoryService.findAll();
        model.addAttribute("newCategory", new CategoryModel());
        model.addAttribute("categories", categories);
        // validate
        if (newProductBindingResult.hasErrors()) {
            return "vendor/category/create";
        }

        if (this.categoryService.existsById(category.getId())) {
            model.addAttribute("error", "Đã tồn tại ID danh mục này");
            return "vendor/category/create";
        }

        if (this.categoryService.existsByName(category.getName())) {
            model.addAttribute("error", "Đã tồn tại tên danh mục này");
            return "vendor/category/create";
        }

        if (category.getId().isEmpty() || category.getName().isEmpty()) {
            model.addAttribute("error", "Chưa nhập ID hoặc tên cho danh mục");
            return "vendor/category/create";
        }

        this.categoryService.save(category);
        return "redirect:/vendor/categories";
    }

    @GetMapping("/category/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable String id) {
        Optional<Category> currentCategory = this.categoryService.findById(id);
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);
        model.addAttribute("currentCategory", currentCategory.get());
        return "vendor/category/update";
    }

    @PostMapping("category/update")
    public String handleUpdateProduct(
            @ModelAttribute("newCategory") @Valid CategoryModel category,
            BindingResult newProductBindingResult) {

        // validate
        if (newProductBindingResult.hasErrors()) {
            return "vendor/category/update";
        }

        CategoryModel newCategory = new CategoryModel();
        newCategory.setId(category.getId());
        newCategory.setName(category.getName());
        newCategory.setStatus(category.getStatus());
        newCategory.setParentCategoryId(category.getParentCategoryId());
        this.categoryService.save(newCategory);

        return "redirect:/vendor/categories";
    }

    @GetMapping("/category/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable String id) {
        Optional<Category> category = this.categoryService.findById(id);
        this.categoryService.delete(category.get());
        return "redirect:/vendor/categories";
    }

    @GetMapping("/category/{id}")
    public String getProductDetailPage(Model model, @PathVariable String id) {
        Optional<Category> category = this.categoryService.findById(id);
        model.addAttribute("category", category.get());
        return "vendor/category/detail";
    }

    @RequestMapping("/category/search")
    public String searchByName(ModelMap model,
                               @RequestParam(name = "name") String name,
                               @RequestParam(defaultValue = "1") int page) {
        int pageSize = 5;

        Pageable pageable = PageRequest.of(page - 1, pageSize, Sort.by("id"));

        Page<Category> resultPage;
        if (StringUtils.hasText(name)) {
            resultPage = categoryService.findByNameLike(name, pageable);
            model.addAttribute("name", name);
        } else {
            resultPage = categoryService.findAll(pageable);
        }

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("categories", resultPage.getContent());
        model.addAttribute("pageNo", totalPages);
        model.addAttribute("currentPage", page);

        return "vendor/category/category-list";
    }

}

