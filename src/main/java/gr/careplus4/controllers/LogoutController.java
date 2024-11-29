package gr.careplus4.controllers;

import gr.careplus4.services.security.JwtCookies;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogoutController {

    @Autowired
    private JwtCookies jwtCookies;

    @GetMapping("/au/logout")
    public String logout(HttpServletResponse response) {
        // Xóa SecurityContext
        SecurityContextHolder.clearContext();

        jwtCookies.removeJwtFromCookies(response);

        // Chuyển hướng về trang login
        return "redirect:/au/login";
    }
}