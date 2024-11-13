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
                // Tạo Cookie cho mã định danh hoặc token của người dùng
                Cookie userCookie = new Cookie("phoneNumber", phoneNumber);
                userCookie.setHttpOnly(true); // Đảm bảo cookie chỉ được gửi trong các yêu cầu HTTP
                userCookie.setPath("/"); // Đặt path cho cookie (sử dụng trên toàn bộ domain)
                userCookie.setMaxAge(7 * 24 * 60 * 60); // Thời hạn cookie (ví dụ: 1 tuần)
                resp.addCookie(userCookie);

                // Lưu thông tin người dùng vào session
                session.setAttribute("phoneNumber", phoneNumber);

                return "redirect:/";
            } else {
                // Đăng nhập thất bại, gửi thông báo lỗi về trang đăng nhập
                model.addAttribute("errorMessage", "User not found or incorrect password");
                return "redirect:/au/login"; // Trả về trang đăng nhập nếu thất bại
            }
        } catch (Exception e) {
            // Xử lý nếu có lỗi từ API hoặc kết nối thất bại
            model.addAttribute("errorMessage", "An error occurred. Please try again. "
                    + e.getMessage());
            return "login";
        }
    }

//    @PostMapping("/au/login/login-submit")
//    public ModelAndView loginSubmit(@Valid @ModelAttribute("userDTO") UserModel userDTO,
//                                    HttpServletRequest request,
//                                    HttpServletResponse response,
//                              BindingResult bindingResult, Model model) {
//        // Kiểm tra lỗi validate của form
//        if (bindingResult.hasErrors()) {
//            return new ModelAndView("redirect:/au/login");
//        }
//
//        // Kiểm tra thông tin đăng nhập
//        if (!userService.checkLogin(userDTO.getPhoneNumber(), userDTO.getPassword())) {
//            model.addAttribute("errorMessage", "Số diện thoại hoặc mật khẩu không đúng." + userDTO.getPhoneNumber() + userDTO.getPassword());
//            return new ModelAndView("login"); // Trả về trang đăng nhập nếu thông tin không đúng
//        }
//        // Đăng nhập thành công, lưu số điện thoại vào session
//        HttpSession session = request.getSession();
//        session.setAttribute("phoneNumber", userDTO.getPhoneNumber());
//        System.out.println("phoneNumber: " + userDTO.getPhoneNumber());
//        System.out.println("remember-me: " + request.getParameter("remember-me"));
//
//        // Nếu người dùng chọn "Remember Me", tạo cookie lưu số điện thoại
//        if ("on".equals(request.getParameter("remember-me"))) {
//            Cookie cookie = new Cookie("phoneNumber", userDTO.getPhoneNumber());
//            cookie.setMaxAge(7 * 24 * 60 * 60); // Cookie tồn tại trong 7 ngày
//            cookie.setPath("/"); // Đảm bảo cookie có thể được gửi trên tất cả các URL trong domain
//            response.addCookie(cookie); // Thêm cookie vào response
//        }
//        model.addAttribute("successMessage", "Đăng nhập thành công!");
//        return new ModelAndView("redirect:/"); // Chuyển đến trang đăng nhập sau khi đăng ký thành công
//    }

    @GetMapping("/au/signup")
    public String signup() {
        return "signup";
    }

//    @PostMapping("/au/signup/signup-submit")
//    public ModelAndView signupSubmit(@Valid @ModelAttribute("user") User user,
//                                     BindingResult bindingResult, Model model) {
//        // Kiểm tra lỗi validate của form
//        if (bindingResult.hasErrors()) {
//            return new ModelAndView("signup");
//        }
//
//        // Kiểm tra xem email đã tồn tại chưa
//        if (userService.emailExists(user.getEmail())) {
//            model.addAttribute("errorMessage", "Email đã được sử dụng.");
//            return new ModelAndView("signup"); // Trả về lại trang đăng ký với thông báo lỗi
//        }
//
//        try {
//            // Lưu người dùng vào database thông qua UserService
//            userService.createUser(user);
//            model.addAttribute("successMessage", "Đăng ký thành công!");
//            return new ModelAndView("redirect:/au/login"); // Chuyển đến trang đăng nhập sau khi đăng ký thành công
//        } catch (Exception e) {
//            model.addAttribute("errorMessage", "Có lỗi xảy ra khi đăng ký. Vui lòng thử lại." + user.toString());
//            return new ModelAndView("signup"); // Trả về trang đăng ký nếu có lỗi
//        }
//    }
}
