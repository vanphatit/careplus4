package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
@Table(name = "User")
public class User implements UserDetails {

    @Id
    @EqualsAndHashCode.Include
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

    @CreationTimestamp
    @Column(name = "CreatedAt", updatable = false, nullable = false)
    private Date createdAt;

    @UpdateTimestamp
    @Column(name = "UpdatedAt", nullable = false)
    private Date updatedAt;

    @ManyToOne
    @JoinColumn(name = "IDRole", nullable = false)
    private Role role;

    @Column(name = "IsActive")
    private boolean isActive;

    @Column(name = "PointEarned")
    @Min(value = 0, message = "Points must be >= 0")
    private int pointEarned;

    @OneToOne(mappedBy = "user")
    private Cart cart;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority(role.getName()));
    }

    @Override
    public String getUsername() {
        return phoneNumber;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true; // Có thể thêm logic kiểm tra nếu cần
    }

    @Override
    public boolean isAccountNonLocked() {
        return true; // Có thể thêm logic kiểm tra nếu cần
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true; // Có thể thêm logic kiểm tra nếu cần
    }

    @Override
    public boolean isEnabled() {
        return isActive;
    }
}