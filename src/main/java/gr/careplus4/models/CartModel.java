package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartModel {
    private String id;
    private String userPhoneNumber;
    private BigDecimal totalAmount;
}
