package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EventModel {
    private String id;
    private String name;
    private Date dateStart;
    private Date dateEnd;
    private BigDecimal discount;
    private Boolean isEdit;
}
