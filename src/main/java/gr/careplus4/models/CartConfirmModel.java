package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartConfirmModel {
    private String id;
    private String userPhoneNumber;
    private int productCount;
    private List<CartDetailConfirmModel> cartDetails;
}
