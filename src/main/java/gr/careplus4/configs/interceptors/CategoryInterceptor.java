package gr.careplus4.configs.interceptors;

import gr.careplus4.entities.Category;
import gr.careplus4.services.impl.CategoryServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Component
public class CategoryInterceptor implements HandlerInterceptor {

    @Autowired
    private CategoryServiceImpl categoryService;

    public CategoryInterceptor(CategoryServiceImpl categoryService) {
        this.categoryService = categoryService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // Code thực hiện trước khi xử lý request
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            List<Category> rootCategories = categoryService.findRootCategoriesWithSubCategories();

            modelAndView.addObject("rootCategories", rootCategories);
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        // Code thực hiện sau khi hoàn tất request
    }
}