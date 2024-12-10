package gr.careplus4.controllers.user.api;

import org.springframework.boot.autoconfigure.task.TaskExecutionProperties;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import static org.apache.logging.log4j.ThreadContext.containsKey;

@RestController
@RequestMapping("/api/otp")
public class OtpController {

    private final JavaMailSender mailSender;

    public OtpController(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    private Map<String, String> otpStorage = new HashMap<>();

    // Gửi OTP qua email
    @PostMapping("/send")
    public ResponseEntity<String> sendOtp(@RequestBody Map<String, String> request) {
        String email = request.get("email");

        // Gửi OTP
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("phatnet4@gmail.com");
        message.setTo(email);
        // send otp 6 digits
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        message.setText("Mã OTP của bạn là: " + otp + ". Vui lòng không chia sẻ mã này với người khác.");
        message.setSubject("Xác minh OTP");
        mailSender.send(message);
        otpStorage.put(email, String.valueOf(otp));

        return ResponseEntity.ok("OTP đã được gửi tới email: " + email);
    }

    // Xác minh OTP
    @PostMapping("/verify")
    public ResponseEntity<String> verifyOtp(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String otp = request.get("otp");
        boolean isValid = otpStorage.containsKey(email) && otpStorage.get(email).equals(otp);

        if (isValid) {
            return ResponseEntity.ok("success");
        } else {
            return ResponseEntity.badRequest().body("Mã OTP không hợp lệ!");
        }
    }
}