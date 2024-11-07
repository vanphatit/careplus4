package gr.careplus4.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Provider")
public class Provider implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    @Size(max = 7)
    private String id;

    @Column(name = "Name", nullable = false, columnDefinition = "NVARCHAR(255)")
    @NotEmpty(message = "Provider name is required")
    private String name;

    @Column(name = "Address", columnDefinition = "NVARCHAR(255)")
    private String address;

    @Column(name = "Phone", length = 10, nullable = false)
    @Pattern(regexp = "^\\d{10}$", message = "Phone number must be 10 digits")
    private String phone;
}