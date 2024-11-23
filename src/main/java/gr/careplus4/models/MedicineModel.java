package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MedicineModel {
    private String id;
    private String name;
    private String description;
    private BigDecimal unitCost;
    private Date expiryDate;
    private Date importDate;
    private int stockQuantity;
    private String dosage;
    private BigDecimal rating;
    private String manufacturerId;
    private String categoryId;
    private String unitId;
    private String image;
    private Boolean isEdit;
}
