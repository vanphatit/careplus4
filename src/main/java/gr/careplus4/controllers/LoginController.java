package gr.careplus4.controllers;

import gr.careplus4.entities.User;
import gr.careplus4.filters.JwtAuthenticationFilter;
import gr.careplus4.models.LoginResponse;
import gr.careplus4.models.LoginUserModel;
import gr.careplus4.models.RegisterUserModel;
import gr.careplus4.models.Response;
import gr.careplus4.services.impl.UserServiceImpl;
import gr.careplus4.services.security.AuthenticationService;
import gr.careplus4.services.security.JwtCookies;
import gr.careplus4.services.security.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.util.stream.Collectors;

@Controller
@RequestMapping("/au")
public class LoginController {

    @Autowired
    private AuthenticationService authenticationService;

    @Autowired
    private JwtService jwtService;

    @Autowired
    private JwtCookies jwtCookies;

    public LoginController(AuthenticationService authenticationService, JwtService jwtService) {
        this.authenticationService = authenticationService;
        this.jwtService = jwtService;
    }

    @GetMapping("/login")
    public String login(HttpServletRequest request) {
        // Kiểm tra JWT có tồn tại và hợp lệ
        if (jwtCookies.isJwtValid(request)) {
            return "redirect:/home";
        }

        return "guest/login";
    }

    @Autowired
    private UserServiceImpl userService;

    @PostMapping("/login/login-submit")
    public ModelAndView checkLogin(@ModelAttribute LoginUserModel loginUser,
                                   @RequestParam(value = "remember-me", required = false) String rememberMe,
                                   HttpServletResponse response) {
        try {
            // Xác thực người dùng
            User authenticatedUser = authenticationService.authenticate(loginUser);

            // Kiểm tra email có đúng định dạng Gmail hay không
            if (!authenticatedUser.getEmail().matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$") || authenticatedUser.getEmail().isEmpty()) {
                ModelAndView mav = new ModelAndView("login");
                mav.addObject("error", "Email must be a valid Gmail address (e.g., user@gmail.com)");
                return mav;
            }

            // Tạo JWT
            long expiration = rememberMe != null ? 604800000L : 3600000L; // 7 ngày hoặc 1 giờ
            String jwtToken = jwtService.generateToken(authenticatedUser, expiration);

            jwtCookies.setJwtToCookies(response, jwtToken, expiration);

            // Chuyển hướng về trang chủ
            return new ModelAndView("redirect:/home");
        } catch (AuthenticationException e) {
            // Trả về trang login với thông báo lỗi
            ModelAndView mav = new ModelAndView("login");
            mav.addObject("error", "Invalid username or password");
            return mav;
        }
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

        if(!registerUser.getEmail().matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$") || registerUser.getEmail().isEmpty()){
            model.addAttribute("errorMessage", "Email phải có dạng ....@gmail.com.");
            return new ModelAndView( "redirect:/au/signup", model);
        }

        registerUser.setIdRole(3);

        if(authenticationService.register(registerUser) != null){
            model.addAttribute("successMessage", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
            return new ModelAndView("forward:/au/login", model);
        }
        model.addAttribute("errorMessage", "Đăng ký thất bại! Vui lòng thử lại.");
        return new ModelAndView( "redirect:/au/signup", model);
    }
}
