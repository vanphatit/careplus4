package gr.careplus4.models;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewDetailModel {
    @NotNull
    private long medicineId;

    @DecimalMin("0.0")
    @DecimalMax("5.0")
    private BigDecimal rating;

    @NotBlank
    private String comment;
}
