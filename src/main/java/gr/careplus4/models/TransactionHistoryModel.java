package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TransactionHistoryModel {
    private String idBill;
    private String userPhone;
    private String receiverName;
    private BigDecimal totalAmount;
    private Date date;
    private Date deliveryDate;
    private String status;
}
