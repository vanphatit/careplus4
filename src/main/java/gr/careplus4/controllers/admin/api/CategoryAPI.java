package gr.careplus4.controllers.admin.api;

import gr.careplus4.entities.Category;
import gr.careplus4.models.CategoryModel;
import gr.careplus4.models.ErrorResponse;
import gr.careplus4.models.MyResponse;
import gr.careplus4.models.Response;
import gr.careplus4.services.impl.CategoryServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("v1/api/category")
public class CategoryAPI {
    @Autowired
    CategoryServiceImpl categoryService;

    @GetMapping
    public ResponseEntity<?> getAllCategory(@RequestParam("page") Optional<String> page) {
        int pageNumber = 1;
        try {
            if (page.isPresent()) {
                pageNumber = Integer.parseInt(page.get());
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        Pageable pageable = PageRequest.of(pageNumber - 1, 5);
        Page<Category> prs = this.categoryService.fetchAllCategories(pageable);
        List<Category> categories = prs.getContent();

        return new ResponseEntity<MyResponse>(new MyResponse(true, "Thành công", prs.getTotalPages(),
                categories), HttpStatus.OK);
    }

    @GetMapping("/getCategoryByName")
    public ResponseEntity<?> getCategoryByName(@RequestParam("categoryName") String categoryName) {
        Optional<Category> category = categoryService.findByCategoryName(categoryName);
        if (category.isPresent()) {
            return new ResponseEntity<Response>(new Response(true,
                    "Thành công", category.get()), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false,
                    "Thất bại", null), HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/getCategory")
    public ResponseEntity<?> getCategory(@Validated @RequestParam("id") String id) {
        Optional<Category> category = categoryService.findById(id);
        if (category.isPresent()) {
            return new ResponseEntity<Response>(new Response(true,
                    "Thành công", category.get()), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false,
                    "Thất bại", null), HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/add")
    public ResponseEntity<?> addCategory(@Validated @ModelAttribute CategoryModel category) {
        if (categoryService.existsByName(category.getName())) {
            return new ResponseEntity<ErrorResponse>(new ErrorResponse(false, "Category đã tồn tại trong hệ thống"),
                    HttpStatus.BAD_REQUEST);
        } else if (categoryService.existsById(category.getId())) {
            return new ResponseEntity<ErrorResponse>(new ErrorResponse(false, "Category Id đã tồn tại trong hệ thống"),
                    HttpStatus.BAD_REQUEST);
        } else {
            category.setStatus(true);
            categoryService.save(category);
            return new ResponseEntity<Response>(new Response(true, "Thêm Thành công", category), HttpStatus.OK);
        }
    }

    @PutMapping(path = "/update")
    public ResponseEntity<?> updateCategory(@Validated @RequestParam("categoryId") String categoryId,
                                            @Validated @RequestParam("categoryName") String categoryName,
                                            @Validated @RequestParam("parentName") String parentName,
                                            @Validated @RequestParam("status") Boolean status) {
        Optional<Category> optCategory = categoryService.findById(categoryId);
        if (optCategory.isEmpty()) {
            return new ResponseEntity<Response>(new Response(false, "Không tìm thấy Category", null), HttpStatus.BAD_REQUEST);
        }else {
            CategoryModel categoryModel = new CategoryModel();
            categoryModel.setId(categoryId);
            categoryModel.setName(categoryName);
            if (parentName != null) {
                Optional<Category> pCategory = categoryService.findByCategoryName(parentName);
                if (pCategory.isPresent()) {
                    categoryModel.setParentCategoryId(pCategory.get().getId());
                }
            }
            categoryModel.setStatus(status);
            categoryService.save(categoryModel);
            return new ResponseEntity<Response>(new
                    Response(true, "Cập nhật Thành công", categoryModel), HttpStatus.OK);
        }
    }

    @DeleteMapping(path = "/delete")
    public ResponseEntity<?> deleteCategory(@Validated @RequestParam("categoryId")
                                            String categoryId){
        Optional<Category> optCategory = categoryService.findById(categoryId);
        if (optCategory.isEmpty()) {
            return new ResponseEntity<Response>(new Response(false, "Không tìm thấy Category", null), HttpStatus.BAD_REQUEST);
        }else if(optCategory.isPresent()) {
            categoryService.delete(optCategory.get());
            return new ResponseEntity<Response>(new Response(true, "Xóa Thành công", optCategory.get()), HttpStatus.OK);
        }
        return null;
    }
}
