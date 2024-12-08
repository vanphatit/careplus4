package gr.careplus4.services.security;

import gr.careplus4.entities.Role;
import gr.careplus4.entities.User;
import gr.careplus4.models.LoginUserModel;
import gr.careplus4.models.RegisterUserModel;
import gr.careplus4.repositories.RoleRepository;
import gr.careplus4.repositories.UserRepository;
import gr.careplus4.services.iRoleService;
import gr.careplus4.services.impl.RoleServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class AuthenticationService {
    @Autowired
    private iRoleService roleService;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;

    public AuthenticationService(UserRepository userRepository,
                                 AuthenticationManager authenticationManager,
                                 PasswordEncoder passwordEncoder) {
        this.authenticationManager = authenticationManager;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public User register(RegisterUserModel registerUserModel) {
        User user = new User();
        user.setPhoneNumber(registerUserModel.getPhone());
        user.setName(registerUserModel.getFullName());
        user.setAddress(registerUserModel.getAddress());
        user.setPassword(passwordEncoder.encode(registerUserModel.getPassword()));
        user.setGender(registerUserModel.getGender());
        user.setEmail(registerUserModel.getEmail());
        user.setRole(roleService.findById(registerUserModel.getIdRole()).get());
        user.setCreatedAt(Date.from(new Date().toInstant()));
        user.setUpdatedAt(Date.from(new Date().toInstant()));
        user.setStatus(true);
        user.setPointEarned(0);
        System.out.println(user);
        return userRepository.save(user);
    }

    public User authenticate (LoginUserModel loginUserModel) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginUserModel.getPhoneNumber(),
                        loginUserModel.getPassword()));
        return userRepository.findByPhoneNumber(loginUserModel.getPhoneNumber()).get();
    }
}
