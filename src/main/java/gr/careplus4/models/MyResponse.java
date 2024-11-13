package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyResponse {
    private Boolean status;
    private String message;
    private int totalPages;
    private Object data;
}
