package gr.careplus4;

import gr.careplus4.configs.CustomSiteMeshFilter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class CarePlus4Application {

    public static void main(String[] args) {
        SpringApplication.run(CarePlus4Application.class, args);
    }

    @Bean
    public FilterRegistrationBean<CustomSiteMeshFilter> siteMeshFilter() {
        FilterRegistrationBean<CustomSiteMeshFilter> filterRegistrationBean
                = new FilterRegistrationBean<CustomSiteMeshFilter>();
        filterRegistrationBean.setFilter(new CustomSiteMeshFilter());
        filterRegistrationBean.addUrlPatterns("/*");
        return filterRegistrationBean;
    }
}