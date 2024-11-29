package gr.careplus4.services.security;

import gr.careplus4.services.impl.UserServiceImpl;
import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class JwtCookies {
    private static final String JWT_COOKIE_NAME = "JWT";

    @Autowired
    private JwtService jwtService;

    @Autowired
    private UserServiceImpl userService;

    public String getJwtFromCookies(@NotNull HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (JWT_COOKIE_NAME.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }


    public void setJwtToCookies(HttpServletResponse response, String jwt, long expiration) {
        // Lưu JWT vào Cookie
        Cookie jwtCookie = new Cookie(JWT_COOKIE_NAME, jwt);
        jwtCookie.setHttpOnly(true); // Bảo mật chống XSS
        //jwtCookie.setSecure(true);   // Chỉ gửi qua HTTPS (bỏ nếu chạy local HTTP)
        jwtCookie.setPath("/");      // Áp dụng cho toàn bộ domain
        jwtCookie.setMaxAge((int) (expiration / 1000)); // Thời gian sống của cookie

        response.addCookie(jwtCookie);
    }

    public void removeJwtFromCookies(HttpServletResponse response) {
        Cookie jwtCookie = new Cookie(JWT_COOKIE_NAME, null);
        jwtCookie.setHttpOnly(true);
        //jwtCookie.setSecure(true);
        jwtCookie.setPath("/");
        jwtCookie.setMaxAge(0);
        response.addCookie(jwtCookie);
    }

    public boolean isJwtValid(HttpServletRequest request) {
        String jwt = getJwtFromCookies(request);
        if (jwt == null) {
            return false;
        }
        try {
            // Giải mã và xác thực JWT bằng JwtService
            String username = jwtService.extractUsername(jwt);
            return username != null && jwtService.isTokenValid(jwt, userService.findByPhoneNumber(username).orElseThrow());
        } catch (ExpiredJwtException e) {
            return false;
        }
    }


    public String getUserPhoneFromJwt(HttpServletRequest request) {
        String jwt = getJwtFromCookies(request);
        return jwtService.extractUsername(jwt);
    }
}
