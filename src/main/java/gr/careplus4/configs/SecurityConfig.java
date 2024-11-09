package gr.careplus4.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests((requests) -> requests.anyRequest().permitAll()
                )
                .formLogin((form) -> form.disable() // Cho phép truy cập vào trang đăng nhập mà không cần xác thực
                )
                .logout((logout) -> logout.disable() // Cho phép truy cập vào trang đăng xuất mà không cần xác thực
                )
                .csrf((csrf) -> csrf.disable());// Tắt CSRF để tránh lỗi trong quá trình phát triển

        return http.build();
    }

    @Bean
    public HttpFirewall allowUrlEncodedSlashHttpFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedSlash(true);  // Cho phép dấu '/' trong URL
        firewall.setAllowUrlEncodedDoubleSlash(true);      // Cho phép dấu '//' trong URL
        return firewall;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}