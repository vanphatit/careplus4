package gr.careplus4.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Manufacturer")
public class Manufacturer implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    @Size(max = 7)
    private String id;

    @Column(name = "Name", nullable = false, columnDefinition = "NVARCHAR(255)")
    @NotEmpty(message = "Manufacturer name is required")
    private String name;
}