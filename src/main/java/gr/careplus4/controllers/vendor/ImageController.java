package gr.careplus4.controllers.vendor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@RestController
public class ImageController {

    @Value("${upload.directory:uploads/medicines}") // Đường dẫn thư mục chứa ảnh
    private String uploadDirectory;

    @GetMapping("/medicine/image")
    public ResponseEntity<byte[]> getImage(@RequestParam String fileName) throws IOException {
        File file = new File(uploadDirectory, fileName);

        if (file.exists()) {
            byte[] imageBytes = new FileInputStream(file).readAllBytes();
            MediaType mediaType = determineMediaType(fileName);
            return ResponseEntity.ok()
                    .contentType(mediaType)
                    .body(imageBytes);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    private MediaType determineMediaType(String fileName) {
        if (fileName.endsWith(".png")) {
            return MediaType.IMAGE_PNG;
        } else if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
            return MediaType.IMAGE_JPEG;
        } else if (fileName.endsWith(".gif")) {
            return MediaType.IMAGE_GIF;
        }
        return MediaType.APPLICATION_OCTET_STREAM;
    }
}
