package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BillModel {
    private String id;
    private String userPhoneNumber;
    private Date date;
    private BigDecimal totalAmount;
    private String method;
    private String eventId;
    private int pointUsed;
    private String status;
}
