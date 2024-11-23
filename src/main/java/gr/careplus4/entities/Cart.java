package gr.careplus4.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Table(name = "Cart")
public class Cart implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    @EqualsAndHashCode.Include
    private String id;

    @OneToOne
    @JoinColumn(name = "UserPhone", nullable = false, unique = true)
    private User user;

    @Column(name = "ProductCount", nullable = false)
    private int productCount;

    @Column(name = "CouponCode", length = 7)
    private String couponCode;

    @Column(name = "UsedPoint", columnDefinition = "bit default 0")
    private Boolean usedPoint;

    @OneToMany(mappedBy = "cart")
    private List<CartDetail> cartDetails;
}