package gr.careplus4.configs;

import gr.careplus4.configs.interceptors.CategoryInterceptor;
import gr.careplus4.configs.interceptors.UserInterceptor;
import gr.careplus4.repositories.UserRepository;
import gr.careplus4.services.impl.CategoryServiceImpl;
import gr.careplus4.services.impl.UserServiceImpl;
import gr.careplus4.services.security.JwtCookies;
import gr.careplus4.services.security.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private CategoryServiceImpl categoryService;

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtCookies jwtCookies;

    @Autowired
    private JwtService jwtService;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new UserInterceptor(userService, jwtCookies, jwtService))
                .addPathPatterns("/**","/admin/**","/vendor/**")
                .excludePathPatterns("/au/**", "/assets/**", "/v1/api/**", "/css/**", "/js/**", "/images/**", "/error/**", "/403");
        registry.addInterceptor(new CategoryInterceptor(categoryService))
                .addPathPatterns("/**")
                .excludePathPatterns("/au/**", "/assets/**", "/v1/api/**", "/css/**", "/js/**", "/images/**","/error/**", "/403");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("classpath:/META-INF/resources/assets/");
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/403").setViewName("exception/403");
    }


    @Bean
    UserDetailsService userDetailsService() {
        return username -> userRepository.findByPhoneNumber(username)
                .orElseThrow(() -> new RuntimeException("User not found"));
    }

    @Bean
    BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }

    @Bean
    AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();

        provider.setUserDetailsService(userDetailsService());
        provider.setPasswordEncoder(passwordEncoder());

        return provider;
    }
}
