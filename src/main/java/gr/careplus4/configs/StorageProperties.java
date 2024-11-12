package gr.careplus4.configs;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Data
@ConfigurationProperties("storage")
public class StorageProperties {
    // Đường dẫn thư mục lưu trữ file (đường dẫn tương đối)
    private String location;
}