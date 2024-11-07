package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Import")
public class Import implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    private String id;

    @ManyToOne
    @JoinColumn(name = "IDProvider", nullable = false)
    private Provider provider;

    @Column(name = "Date")
    @Temporal(TemporalType.DATE)
    private Date date;

    @Column(name = "TotalAmount", precision = 10, scale = 2, nullable = false)
    @DecimalMin("0.00")
    private BigDecimal totalAmount;
}