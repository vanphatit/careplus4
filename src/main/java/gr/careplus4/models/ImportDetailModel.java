package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImportDetailModel {
    private String importId;
    private String medicineId;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal subTotal;
}
