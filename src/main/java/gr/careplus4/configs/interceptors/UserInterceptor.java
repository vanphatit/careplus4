package gr.careplus4.configs.interceptors;

import gr.careplus4.entities.User;
import gr.careplus4.services.impl.UserServiceImpl;
import gr.careplus4.services.security.JwtCookies;
import gr.careplus4.services.security.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.Optional;

@Component
public class UserInterceptor implements HandlerInterceptor {

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private JwtCookies jwtCookies;

    @Autowired
    private JwtService jwtService;

    public UserInterceptor(UserServiceImpl userService, JwtCookies jwtCookies, JwtService jwtService) {
        this.userService = userService;
        this.jwtCookies = jwtCookies;
        this.jwtService = jwtService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // Code thực hiện trước khi xử lý request
        if(jwtCookies.getUserPhoneFromJwt(request) != null){
            Optional<User> user = userService.findByPhoneNumber(jwtCookies.getUserPhoneFromJwt(request));
            if(user.isPresent()){
                request.setAttribute("user", user.get());
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            User user = (User) request.getAttribute("user");
            if (user != null) {
                modelAndView.addObject("user", user);
            } else {
                modelAndView.addObject("user", null);
            }
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}