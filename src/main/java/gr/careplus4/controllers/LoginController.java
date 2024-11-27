package gr.careplus4.controllers;

import gr.careplus4.entities.User;
import gr.careplus4.models.LoginResponse;
import gr.careplus4.models.LoginUserModel;
import gr.careplus4.models.RegisterUserModel;
import gr.careplus4.models.Response;
import gr.careplus4.services.impl.UserServiceImpl;
import gr.careplus4.services.security.AuthenticationService;
import gr.careplus4.services.security.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/au")
public class LoginController {

    private final AuthenticationService authenticationService;
    private final JwtService jwtService;

    public LoginController(AuthenticationService authenticationService, JwtService jwtService) {
        this.authenticationService = authenticationService;
        this.jwtService = jwtService;
    }

    @GetMapping("/login")
    public String login() {
        System.out.println("Login page");
        return "guest/login";
    }

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private UserServiceImpl userService;

    @PostMapping("/login/login-submit")
    public String checkLogin(@RequestBody LoginUserModel loginUser,
                             @RequestParam(value = "remember-me", required = false) String rememberMe, // Add remember-me parameter
                             Model model) {
        User authenticatedUser = authenticationService.authenticate(loginUser);

        String jwtToken = jwtService.generateToken(authenticatedUser);

        LoginResponse loginResponse = new LoginResponse();
        loginResponse.setToken(jwtToken);
        loginResponse.setExpireTime(jwtService.getExpirationTime());

        return "guest/home";
    }


    @GetMapping("/signup")
    public String signup() {
        return "guest/signup";
    }

    @PostMapping("/signup/signup-submit")
    @Transactional
    public ModelAndView register(@RequestBody RegisterUserModel registerUser, Model model) {
        // Kiểm tra xác nhận mật khẩu
        if (!registerUser.getPassword().equals(registerUser.getRePassword())) {
            model.addAttribute("errorMessage", "Mật khẩu và xác nhận mật khẩu không khớp.");
            return new ModelAndView("guest/signup");
        }
        User registeredUser = authenticationService.register(registerUser);
        return new ModelAndView("redirect:/au/login");
    }

//    @PostMapping("/signup/signup-submit")
//    public String signup(@RequestParam("name") String name,
//                         @RequestParam("phoneNumber") String phoneNumber,
//                         @RequestParam("password") String password,
//                         @RequestParam("re_pass") String rePass,
//                         @RequestParam("gender") String gender,
//                         @RequestParam("email") String email,
//                         @RequestParam("address") String address,
//                         @RequestParam("role") int role,
//                         Model model) {
//        // Kiểm tra xác nhận mật khẩu
//        if (!password.equals(rePass)) {
//            model.addAttribute("errorMessage", "Mật khẩu và xác nhận mật khẩu không khớp.");
//            return "signup";
//        }
//
//        String apiUrl = apibaseUrl + "/user/addUser";
//
//        // Tạo request để gửi đến API
//        MultiValueMap<String, String> requestParams = new LinkedMultiValueMap<>();
//        requestParams.add("name", name);
//        requestParams.add("phoneNumber", phoneNumber);
//        requestParams.add("password", password);
//        requestParams.add("gender", gender);
//        requestParams.add("email", email);
//        requestParams.add("address", address);
//        requestParams.add("role", String.valueOf(role));
//
//        try {
//            // Gửi POST request tới API
//            ResponseEntity<Response> response = restTemplate.postForEntity(apiUrl, requestParams, Response.class);
//
//            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null && response.getBody().getStatus()) {
//                model.addAttribute("successMessage", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
//                return "redirect:/au/login"; // Điều hướng đến trang đăng nhập khi thành công
//            } else {
//                model.addAttribute("errorMessage", "Số điện thoại hoặc email đã tồn tại.");
//                return "signup"; // Trả về trang đăng ký nếu thất bại
//            }
//        } catch (Exception e) {
//            model.addAttribute("errorMessage", "Đã xảy ra lỗi. Vui lòng thử lại sau. ");
//            return "signup"; // Trả về trang đăng ký nếu có lỗi
//        }
//    }
}
