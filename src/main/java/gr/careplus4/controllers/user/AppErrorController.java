package gr.careplus4.controllers.user;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/error")
public class AppErrorController implements ErrorController {

    private static final String ERROR_PATH = "/error";

    @RequestMapping
    public String handleError(HttpServletRequest request, Model model) {
        // Lấy thông tin lỗi từ request
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
        String errorMessage = (String) request.getAttribute("jakarta.servlet.error.message");

        // Tạo dữ liệu gửi đến view JSP
        Map<String, Object> errorAttributes = new HashMap<>();
        errorAttributes.put("statusCode", statusCode);
        errorAttributes.put("errorMessage", errorMessage);
        errorAttributes.put("path", request.getAttribute("jakarta.servlet.error.request_uri"));

        // Gửi dữ liệu tới JSP
        model.addAllAttributes(errorAttributes);

        if (statusCode == 404) {
            return "exception/404"; // File 404.jsp
        } else if (statusCode == 500) {
            return "exception/500"; // File 500.jsp
        } else {
            return "exception/error"; // Trang lỗi chung
        } // Tên file JSP
    }

//    @Override
    public String getErrorPath() {
        return ERROR_PATH;
    }

    @RequestMapping("/test-400")
    public String test400(@RequestParam String requiredParam) {
        return "exception/500";
    }

}
