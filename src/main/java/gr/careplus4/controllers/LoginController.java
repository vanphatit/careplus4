package gr.careplus4.controllers;

import gr.careplus4.entities.User;
import gr.careplus4.models.Response;
import gr.careplus4.models.UserModel;
import gr.careplus4.repositories.RoleRepository;
import gr.careplus4.services.iRoleService;
import gr.careplus4.services.impl.RoleServiceImpl;
import gr.careplus4.services.impl.UserServiceImpl;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/au")
public class LoginController {
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private UserServiceImpl userService;

    @Value("${api.base-url}")
    private String apibaseUrl;

    @PostMapping("/login/login-submit")
    public String checkLogin(@RequestParam("phoneNumber") String phoneNumber,
                             @RequestParam("password") String password,
                             @RequestParam(value = "remember-me", required = false) String rememberMe, // Add remember-me parameter
                             Model model, HttpSession session, HttpServletResponse resp) {
        String apiUrl = apibaseUrl + "/user/getUserLogin";

        // Tạo request gửi đến API đăng nhập
        MultiValueMap<String, String> requestParams = new LinkedMultiValueMap<>();
        requestParams.add("phoneNumber", phoneNumber);
        requestParams.add("password", password);

        try {
            // Gửi yêu cầu POST tới API
            ResponseEntity<Response> response = restTemplate.postForEntity(apiUrl, requestParams, Response.class);
            if (response.getBody() != null && response.getBody().getStatus()) {
                // Đăng nhập thành công, chuyển hướng đến trang chủ

                if ("on".equals(rememberMe)) { // Only if remember-me is checked
                    // Tạo Cookie cho mã định danh hoặc token của người dùng
                    Cookie userCookie = new Cookie("phoneNumber", phoneNumber);
                    userCookie.setHttpOnly(true); // Đảm bảo cookie chỉ được gửi trong các yêu cầu HTTP
                    userCookie.setPath("/"); // Đặt path cho cookie (sử dụng trên toàn bộ domain)
                    userCookie.setMaxAge(7 * 24 * 60 * 60); // Thời hạn cookie (ví dụ: 1 tuần)
                    resp.addCookie(userCookie);

                    // Lưu thông tin người dùng vào session
                    session.setAttribute("phoneNumber", phoneNumber);
                }

                return "redirect:/";
            } else {
                // Đăng nhập thất bại, gửi thông báo lỗi về trang đăng nhập
                model.addAttribute("errorMessage", "User not found or incorrect password");
                return "redirect:/au/login"; // Trả về trang đăng nhập nếu thất bại
            }
        } catch (Exception e) {
            // Xử lý nếu có lỗi từ API hoặc kết nối thất bại
            model.addAttribute("errorMessage", "An error occurred. Please try again.");
            return "login";
        }
    }


    @GetMapping("/signup")
    public String signup() {
        return "signup";
    }

    @PostMapping("/signup/signup-submit")
    public String signup(@RequestParam("name") String name,
                         @RequestParam("phoneNumber") String phoneNumber,
                         @RequestParam("password") String password,
                         @RequestParam("re_pass") String rePass,
                         @RequestParam("gender") String gender,
                         @RequestParam("email") String email,
                         @RequestParam("address") String address,
                         @RequestParam("role") int role,
                         Model model) {
        // Kiểm tra xác nhận mật khẩu
        if (!password.equals(rePass)) {
            model.addAttribute("errorMessage", "Mật khẩu và xác nhận mật khẩu không khớp.");
            return "signup";
        }

        String apiUrl = apibaseUrl + "/user/addUser";

        // Tạo request để gửi đến API
        MultiValueMap<String, String> requestParams = new LinkedMultiValueMap<>();
        requestParams.add("name", name);
        requestParams.add("phoneNumber", phoneNumber);
        requestParams.add("password", password);
        requestParams.add("gender", gender);
        requestParams.add("email", email);
        requestParams.add("address", address);
        requestParams.add("role", String.valueOf(role));

        try {
            // Gửi POST request tới API
            ResponseEntity<Response> response = restTemplate.postForEntity(apiUrl, requestParams, Response.class);

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null && response.getBody().getStatus()) {
                model.addAttribute("successMessage", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
                return "redirect:/au/login"; // Điều hướng đến trang đăng nhập khi thành công
            } else {
                model.addAttribute("errorMessage", "Số điện thoại hoặc email đã tồn tại.");
                return "signup"; // Trả về trang đăng ký nếu thất bại
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Đã xảy ra lỗi. Vui lòng thử lại sau. ");
            return "signup"; // Trả về trang đăng ký nếu có lỗi
        }
    }
}
