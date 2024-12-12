package gr.careplus4.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Category")
public class Category implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    @Size(max = 7)
    private String id;

    @Column(name = "Name", nullable = false, columnDefinition = "NVARCHAR(255)")
    @NotEmpty(message = "Category name is required")
    private String name;

    @Column(name = "Status", columnDefinition = "bit")
    @NotNull(message = "Category status is required")
    private Boolean status;

    @ManyToOne
    @JoinColumn(name = "ParentID")
    @ToString.Exclude
    @JsonBackReference // Đánh dấu trường này để Jackson không chuyển đổi nó thành JSON và tránh recursion
    private Category parentCategory;

    @OneToMany(mappedBy = "parentCategory")
    @ToString.Exclude
    private List<Category> subCategories;
}