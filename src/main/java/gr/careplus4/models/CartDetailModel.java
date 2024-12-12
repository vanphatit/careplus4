package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDetailModel {
    private Long cartDetailId;
    private String medicineId;
    private String image;
    private String unitName;
    private int quantity;
    private BigDecimal unitCost;
    private BigDecimal subTotal;
}
