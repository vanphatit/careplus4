package gr.careplus4.exceptions;

public class StorageException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    // Constructor với thông điệp lỗi
    public StorageException(String message) {
        super(message);
    }

    // Constructor với thông điệp lỗi và ngoại lệ gốc
    public StorageException(String message, Throwable cause) {
        super(message, cause);
    }
}
