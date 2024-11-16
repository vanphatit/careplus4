package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "User")
public class User implements Serializable {

    @Id
    @Column(name = "PhoneNumber", length = 10)
    @Pattern(regexp = "^\\d{10}$", message = "Phone number must be 10 digits")
    private String phoneNumber;

    @Column(name = "Name", length = 255, nullable = false)
    @NotEmpty(message = "User name is required")
    private String name;

    @Column(name = "Address", length = 255)
    private String address;

    @Column(name = "Password", length = 255, nullable = false)
    @NotEmpty(message = "Password is required")
    private String password;

    @Column(name = "Gender", length = 1)
    @Pattern(regexp = "^[MF]$", message = "Gender must be M or F")
    private String gender;

    @Column(name = "Email", length = 255, nullable = false, unique = true)
    @Email(message = "Email should be valid")
    private String email;

    @ManyToOne
    @JoinColumn(name = "IDRole", nullable = false)
    private Role role;

    @Column(name = "IsActive")
    private boolean isActive;

    @Column(name = "PointEarned")
    @Min(value = 0, message = "Points must be >= 0")
    private int pointEarned;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private Cart cart;

}