package gr.careplus4.services.impl;

import gr.careplus4.configs.StorageProperties;
import gr.careplus4.services.iStorageServices;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.apache.commons.io.FilenameUtils;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import gr.careplus4.exceptions.StorageException;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileSystemStorageServiceImpl implements iStorageServices {
    private final Path rootLocation;

    public FileSystemStorageServiceImpl(StorageProperties properties) {
        this.rootLocation = Paths.get(properties.getLocation());
    }

    @Override
    public void init() {
        try {
            Files.createDirectories(rootLocation);
            System.out.println("Thư mục lưu trữ đã được tạo: " + rootLocation.toString());
        } catch (Exception e) {
            throw new StorageException("Không thể tạo thư mục lưu trữ: ", e);
        }
    }

    @Override
    public void store(MultipartFile file, String storeFilename) {
        try {
            if (file.isEmpty()) {
                throw new StorageException("Không thể lưu file trống");
            }
            Path destinationFile = this.rootLocation.resolve(Paths.get(storeFilename)).normalize().toAbsolutePath();
            if (!destinationFile.getParent().equals(this.rootLocation.toAbsolutePath())) {
                throw new StorageException("Không thể lưu file ngoài thư mục hiện tại");
            }
            try (InputStream inputStream = file.getInputStream()) {
                Files.copy(inputStream, destinationFile, StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (Exception e) {
            throw new StorageException("Lỗi khi lưu file: ", e);
        }
    }

    @Override
    public String getStorageFilename(MultipartFile file, String id) {
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        return "p" + id + "." + ext;
    }

    @Override
    public Path load(String filename) {
        return rootLocation.resolve(filename);
    }

    @Override
    public Resource loadAsResource(String filename) {
        try {
            Path file = load(filename);
            Resource resource = new UrlResource(file.toUri());
            if (resource.exists() || resource.isReadable()) {
                return resource;
            } else {
                throw new StorageException("Không thể đọc file: " + filename);
            }
        } catch (Exception e) {
            throw new StorageException("Không thể tải file: " + filename, e);
        }
    }

    @Override
    public void delete(String storeFilename) throws Exception {
        Path file = load(storeFilename);
        Files.deleteIfExists(file);
    }
}
