package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Cart")
public class Cart implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    private String id;

    @ManyToOne
    @JoinColumn(name = "UserPhone", nullable = false)
    private User user;

    @Column(name = "TotalAmount", precision = 10, scale = 2, nullable = false)
    @DecimalMin("0.01")
    private BigDecimal totalAmount;
}