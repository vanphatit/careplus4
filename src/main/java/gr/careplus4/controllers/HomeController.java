package gr.careplus4.controllers;

import gr.careplus4.entities.User;
import gr.careplus4.models.UserModel;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping({"", "/", "/home"})
    public String index(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        Cookie[] cookies = request.getCookies();

        // Kiểm tra xem đã có session chưa
        if (session == null || session.getAttribute("phoneNumber") == null) {
            // Nếu chưa có session, kiểm tra cookie "phoneNumber"
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("phoneNumber".equals(cookie.getName())) {
                        // Lấy số điện thoại từ cookie và tự động đăng nhập
                        String phoneNumber = cookie.getValue();
                        session = request.getSession(true);
                        session.setAttribute("phoneNumber", phoneNumber);

                        break;
                    }
                }
            }
        }

//        for (Cookie cookie : cookies) {
//            if ("phoneNumber".equals(cookie.getName())) {
//                String phoneNumber = cookie.getValue();
//                System.out.println("phoneNumber: " + phoneNumber);
//                break;
//            }
//        }
        return "home";
    }
}