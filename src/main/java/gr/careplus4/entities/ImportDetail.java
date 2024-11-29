package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "ImportDetail")
public class ImportDetail implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;


    @ManyToOne
    @JoinColumn(name = "IDImport", nullable = false)
    private Import importRecord;


    @ManyToOne
    @JoinColumn(name = "IDMedicine", nullable = false)
    private Medicine medicine;

    @Column(name = "Quantity", nullable = false)
    @Min(value = 1, message = "Quantity must be > 0")
    private int quantity;

    @Column(name = "UnitPrice", precision = 10, scale = 2, nullable = false)
    @DecimalMin("0.01")
    private BigDecimal unitPrice;

    @Column(name = "SubTotal", precision = 10, scale = 2, nullable = false)
    private BigDecimal subTotal;

    @PrePersist
    @PreUpdate
    private void calculateSubTotal() {
        this.subTotal = this.unitPrice.multiply(BigDecimal.valueOf(this.quantity));
    }
}