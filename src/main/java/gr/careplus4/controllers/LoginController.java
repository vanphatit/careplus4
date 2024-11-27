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
import org.springframework.ui.ModelMap;
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
    public ModelAndView checkLogin(@ModelAttribute LoginUserModel loginUser,
                             @RequestParam(value = "remember-me", required = false) String rememberMe) {
        User authenticatedUser = authenticationService.authenticate(loginUser);

        String jwtToken = jwtService.generateToken(authenticatedUser);

        LoginResponse loginResponse = new LoginResponse();
        loginResponse.setToken(jwtToken);
        loginResponse.setExpireTime(jwtService.getExpirationTime());

        return new ModelAndView("redirect:/home");
    }


    @GetMapping("/signup")
    public String signup(@RequestParam(value = "errorMessage", required = false) String error,
                         Model model) {
        if (error != null) {
            model.addAttribute("errorMessage", error);
        }
        return "guest/signup";
    }

    @PostMapping("/signup/signup-submit")
    @Transactional
    public ModelAndView register(@ModelAttribute RegisterUserModel registerUser, ModelMap model) {
        // Kiểm tra xác nhận mật khẩu
        if (!registerUser.getPassword().equals(registerUser.getRePassword())) {
            model.addAttribute("errorMessage", "Mật khẩu và xác nhận mật khẩu không khớp.");
            return new ModelAndView("redirect:/au/signup", model);
        }

        if(userService.findByPhoneNumber(registerUser.getPhone()).isPresent()){
            model.addAttribute("errorMessage", "Số điện thoại đã tồn tại.");
            return new ModelAndView( "redirect:/au/signup", model);
        }

        if(userService.findByEmail(registerUser.getEmail()).isPresent()){
            model.addAttribute("errorMessage", "Email đã tồn tại.");
            return new ModelAndView( "redirect:/au/signup", model);
        }

        registerUser.setIdRole(2);

        if(authenticationService.register(registerUser) != null){
            model.addAttribute("successMessage", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
            return new ModelAndView("forward:/au/login", model);
        }
        model.addAttribute("errorMessage", "Đăng ký thất bại! Vui lòng thử lại.");
        return new ModelAndView( "redirect:/au/signup", model);
    }
}
