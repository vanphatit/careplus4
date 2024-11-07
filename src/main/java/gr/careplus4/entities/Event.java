package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
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
@Table(name = "Event")
public class Event implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    private String id;

    @Column(name = "Name", length = 255, nullable = false)
    @NotEmpty(message = "Event name is required")
    private String name;

    @Column(name = "DateStart")
    @Temporal(TemporalType.DATE)
    private Date dateStart;

    @Column(name = "DateEnd")
    @Temporal(TemporalType.DATE)
    private Date dateEnd;

    @Column(name = "Discount", precision = 5, scale = 2)
    @DecimalMin("0.00")
    private BigDecimal discount;
}