package gr.careplus4.models;

import jakarta.validation.constraints.Null;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

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
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date expiryDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date importDate;
    private int stockQuantity;
    private String dosage;
    private BigDecimal rating;
    private String manufacturerId;
    private String categoryId;
    private String unitId;
    private MultipartFile image;
    private String imageUrl;
    private Boolean isEdit;
}
