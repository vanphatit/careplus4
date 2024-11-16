package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Cart")
public class Cart implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    private String id;

    @OneToOne
    @JoinColumn(name = "UserPhone", nullable = false, unique = true)
    private User user;

    @Column(name = "ProductCount", nullable = false)
    private int productCount;

    @OneToMany(mappedBy = "cart")
    private List<CartDetail> cartDetails = new ArrayList<>();
}