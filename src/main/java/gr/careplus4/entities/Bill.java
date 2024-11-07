package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
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
@Table(name = "Bill")
public class Bill implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    private String id;

    @ManyToOne
    @JoinColumn(name = "UserPhone", nullable = false)
    private User user;

    @Column(name = "Date")
    @Temporal(TemporalType.DATE)
    private Date date;

    @Column(name = "TotalAmount", precision = 10, scale = 2, nullable = false)
    @DecimalMin("0.01")
    private BigDecimal totalAmount;

    @Column(name = "Method", length = 10)
    private String method;

    @ManyToOne
    @JoinColumn(name = "IDEvent")
    private Event event;

    @Column(name = "PointUsed")
    @Min(value = 0, message = "Points used must be >= 0")
    private int pointUsed;

    @Column(name = "Status", columnDefinition = "NVARCHAR(255)", nullable = false)
    @NotEmpty(message = "Status is required")
    private String status;
}