package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "MedicineCopy")
public class MedicineCopy {

    @Id
    @Column(name = "ID", length = 7)
    @Size(max = 7)
    private String id;

    @Column(name = "Name", length = 255, nullable = false)
    @NotEmpty(message = "Medicine name is required")
    private String name;

    @Column(name = "Description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "UnitCost", precision = 10, scale = 2)
    @DecimalMin(value = "0.0", inclusive = true, message = "Unit cost must be >= 0")
    private BigDecimal unitCost;

    @Column(name = "ExpiryDate")
    @Temporal(TemporalType.DATE)
    private Date expiryDate;

    @Column(name = "StockQuantity")
    @Min(value = 0, message = "Stock quantity must be >= 0")
    private int stockQuantity;

    @Column(name = "Dosage", length = 255)
    private String dosage;

    @Column(name = "Rating", precision = 2, scale = 1)
    @DecimalMin("0.0")
    @DecimalMax("5.0")
    private BigDecimal rating;

    @Column(name = "ImportDate")
    @Temporal(TemporalType.DATE)
    private Date importDate;

    @Column(name = "Image", length = 4086)
    @NotEmpty(message = "Image is required")
    private String image;

    private String manufacturerName;

    private String categoryName;

    private String unitName;

    @OneToOne
    @JoinColumn(name = "bill_detail_id", referencedColumnName = "id", nullable = false, unique = true)
    @ToString.Exclude
    private BillDetail billDetail;
}
