package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegisterUserModel {
    private String phone;
    private String fullName;
    private String password;
    private String rePassword;
    private String gender;
    private String email;
    private String address;
    private int idRole;
}
