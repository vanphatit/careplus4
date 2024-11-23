package gr.careplus4.models;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewDetailModel {
    @NotNull
    private String medicineId;

    @Min(1)
    @Max(5)
    private Integer rating;

    @NotBlank
    private String comment;
}
