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
@Table(name = "BillDetail")
public class BillDetail implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "IDBill", nullable = false)
    private Bill bill;

    @ManyToOne
    @JoinColumn(name = "IDMedicine", nullable = false)
    private Medicine medicine;

    @Column(name = "Quantity", nullable = false)
    @Min(value = 1, message = "Quantity must be > 0")
    private int quantity;

    @Column(name = "UnitCost", precision = 10, scale = 2, nullable = false)
    @DecimalMin("0.01")
    private BigDecimal unitCost;

    @Column(name = "SubTotal", precision = 10, scale = 2, nullable = false)
    private BigDecimal subTotal;

    @PrePersist
    @PreUpdate
    private void calculateSubTotal() {
        this.subTotal = this.unitCost.multiply(BigDecimal.valueOf(this.quantity));
    }
}