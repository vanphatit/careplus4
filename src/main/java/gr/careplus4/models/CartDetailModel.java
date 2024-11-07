package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDetailModel {
    private String cartId;
    private String medicineId;
    private int quantity;
    private BigDecimal unitCost;
    private BigDecimal subTotal;
}
