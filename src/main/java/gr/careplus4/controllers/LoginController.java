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
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
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

    @Autowired
    private PasswordEncoder passwordEncoder;

    public LoginController(AuthenticationService authenticationService, JwtService jwtService) {
        this.authenticationService = authenticationService;
        this.jwtService = jwtService;
    }

    @GetMapping("/login")
    public String login(@RequestParam(value = "error", required = false) String error,
                        @RequestParam(value = "success", required = false) String success,
                        HttpServletRequest request, Model model) {
        // Kiểm tra JWT có tồn tại và hợp lệ
        if (jwtCookies.isJwtValid(request)) {
            return "redirect:/home";
        }

        if (error != null) {
            model.addAttribute("error", error);
        }
        if (success != null) {
            model.addAttribute("success", success);
        }

        return "guest/login";
    }

    @GetMapping("/forgot-password")
    public String forgotPassword(@RequestParam(value = "error", required = false) String error,
                                 @RequestParam(value = "success", required = false) String success,
                                 Model model) {
        if (error != null) {
            model.addAttribute("error", error);
        }
        if (success != null) {
            model.addAttribute("success", success);
        }
        return "guest/forgot-password";
    }

    @PostMapping("/forgot-password")
    public ModelAndView forgotPassword(@RequestParam("email") String email,
                              @RequestParam("password") String password,
                              @RequestParam("repassword") String rePassword, ModelMap model) {
        if (email.isEmpty() || password.isEmpty() || rePassword.isEmpty()) {
            model.addAttribute("error", "Vui lòng điền đầy đủ thông tin.");
            return new ModelAndView("redirect:/au/forgot-password", model);
        }

        if (!password.equals(rePassword)) {
            model.addAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp.");
            return new ModelAndView("redirect:/au/forgot-password", model);
        }

        User user = userService.findByEmail(email).orElse(null);
        if (user == null) {
            model.addAttribute("error", "Email không tồn tại.");
            return new ModelAndView("redirect:/au/forgot-password", model);
        }

        user.setPassword(passwordEncoder.encode(password));
        userService.save(user);
        model.addAttribute("success", "Đổi mật khẩu thành công! Bạn có thể đăng nhập ngay.");
        return new ModelAndView("redirect:/au/login", model);
    }

    @Autowired
    private UserServiceImpl userService;

    @PostMapping("/login/login-submit")
    public ModelAndView checkLogin(@ModelAttribute LoginUserModel loginUser, OAuth2AuthenticationToken oauth2Token,
                                   @RequestParam(value = "remember-me", required = false) String rememberMe,
                                   HttpServletResponse response, ModelMap model) {
        try {

            // Xác thực người dùng
            User authenticatedUser = authenticationService.authenticate(loginUser);

            // Kiểm tra email có đúng định dạng Gmail hay không
            if (!authenticatedUser.getEmail().matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$") || authenticatedUser.getEmail().isEmpty()) {
                model.addAttribute("error", "Email phải có dạng ....@gmail.com.");
                return new ModelAndView("redirect:/au/login", model);
            }

            // Tạo JWT
            long expiration = rememberMe != null ? 604800000L : 3600000L; // 7 ngày hoặc 1 giờ
            String jwtToken = jwtService.generateToken(authenticatedUser, expiration);

            jwtCookies.setJwtToCookies(response, jwtToken, expiration);

            // Chuyển hướng về trang chủ
            model.addAttribute("success", "Đăng nhập thành công!");
            return new ModelAndView("redirect:/home", model);
        } catch (AuthenticationException e) {
            // Trả về trang login với thông báo lỗi
            model.addAttribute("error", "Đăng nhập thất bại! Vui lòng thử lại.");
            return new ModelAndView("redirect:/au/login", model);
        }
    }

    @GetMapping("/login/oauth2Google-submit")
    public ModelAndView oauth2GoogleSubmit(OAuth2AuthenticationToken oauth2Token, ModelMap model,
                                           HttpServletResponse response) {

        if (oauth2Token == null || oauth2Token.getPrincipal() == null) {
            model.addAttribute("error", "Đăng nhập thất bại! Vui lòng thử lại.");
            return new ModelAndView("redirect:/au/login", model);
        }

        // Lấy thông tin người dùng từ Google
        String email = oauth2Token.getPrincipal().getAttribute("email");
        String name = oauth2Token.getPrincipal().getAttribute("name");

        if(email == null){
            model.addAttribute("error", "Đăng nhập thất bại! Vui lòng thử lại.");
            return new ModelAndView("redirect:/au/login", model);
        }

        if(userService.findByEmail(email).isPresent()){
            User user = userService.findByEmail(email).get();
            // Tạo JWT
            long expiration = 3600000L; // 1 giờ
            String jwtToken = jwtService.generateToken(user, expiration);

            // Lưu JWT vào Cookie
            jwtCookies.setJwtToCookies(response, jwtToken, expiration);

            model.addAttribute("success", "Đăng nhập thành công!");
            return new ModelAndView("redirect:/", model);
        } else {
            model.addAttribute("email", email);
            model.addAttribute("name", name);
            model.addAttribute("error", "Tài khoản chưa tồn tại! Vui lòng đăng ký.");
            return new ModelAndView("forward:/au/signup", model);
        }
    }

    @GetMapping("/signup")
    public String signup(@RequestParam(value = "error", required = false) String error,
                         @RequestParam(value = "email", required = false) String email,
                         @RequestParam(value = "name", required = false) String name,
                         Model model) {
        if (error != null) {
            model.addAttribute("error", error);
        }
        if (email != null) {
            model.addAttribute("email", email);
        }
        if (name != null) {
            model.addAttribute("name", name);
        }
        return "guest/signup";
    }

    @PostMapping("/signup/signup-submit")
    @Transactional
    public ModelAndView register(@ModelAttribute RegisterUserModel registerUser, ModelMap model) {

        if(!registerUser.getEmail().isEmpty() && registerUser.getEmail().matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$")){
            model.addAttribute("email", registerUser.getEmail());
        }
        if(!registerUser.getFullName().isEmpty()){
            model.addAttribute("name", registerUser.getFullName());
        }

        // Kiểm tra xác nhận mật khẩu
        if (!registerUser.getPassword().equals(registerUser.getRePassword())) {
            model.addAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp.");
            return new ModelAndView("redirect:/au/signup", model);
        }

        if(userService.findByPhoneNumber(registerUser.getPhone()).isPresent()){
            model.addAttribute("error", "Số điện thoại đã tồn tại.");
            return new ModelAndView( "redirect:/au/signup", model);
        }

        if(userService.findByEmail(registerUser.getEmail()).isPresent()){
            model.addAttribute("error", "Email đã tồn tại.");
            return new ModelAndView( "redirect:/au/signup", model);
        }

        if(!registerUser.getEmail().matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$") || registerUser.getEmail().isEmpty()){
            model.addAttribute("error", "Email phải có dạng ....@gmail.com.");
            return new ModelAndView( "redirect:/au/signup", model);
        }

        registerUser.setIdRole(3);

        if(authenticationService.register(registerUser) != null){
            model.addAttribute("success", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
            return new ModelAndView("redirect:/au/login", model);
        }
        model.addAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
        return new ModelAndView( "redirect:/au/signup", model);
    }
}
