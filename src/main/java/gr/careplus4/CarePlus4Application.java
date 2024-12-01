package gr.careplus4;

import gr.careplus4.configs.CustomSiteMeshFilter;
import gr.careplus4.configs.StorageProperties;
import gr.careplus4.services.iStorageServices;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.core.Ordered;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)
public class CarePlus4Application {

    public static void main(String[] args) {
        SpringApplication.run(CarePlus4Application.class, args);
    }

    @Bean
    public FilterRegistrationBean<CustomSiteMeshFilter> siteMeshFilter() {
        FilterRegistrationBean<CustomSiteMeshFilter> filter = new FilterRegistrationBean<>();
        filter.setFilter(new CustomSiteMeshFilter());
        filter.addUrlPatterns("/*"); // Áp dụng SiteMesh cho tất cả các URL
        filter.setOrder(Ordered.HIGHEST_PRECEDENCE + 1); // Đảm bảo chạy sau Security
        return filter;
    }

    @Bean
    CommandLineRunner init(iStorageServices storageService) {
        return (args -> {
            storageService.init();
        });
    }
}