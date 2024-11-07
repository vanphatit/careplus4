package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserModel {
    private String phoneNumber;
    private String name;
    private String address;
    private String password;
    private String gender;
    private String email;
    private int roleId;
    private boolean isActive;
    private int pointEarned;
}
