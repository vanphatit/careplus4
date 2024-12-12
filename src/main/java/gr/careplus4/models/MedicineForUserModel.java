package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MedicineForUserModel {
    private String id;
    private String name;
    private String description;
    private BigDecimal unitCost;
    private int stockQuantity;
    private String dosage;
    private BigDecimal rating;
    private String manufacturerName;
    private String categoryName;
    private String unitName;
    private Date expiryDate;
    private String image;
    private List<Map<String, String>> ingredients; // Thành phần
    private String usage;
    private String directions;
    private String sideEffects;
    private String precautions;
    private String storage;
}
