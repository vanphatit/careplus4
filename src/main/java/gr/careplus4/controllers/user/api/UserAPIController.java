package gr.careplus4.controllers.user.api;

import gr.careplus4.entities.Role;
import gr.careplus4.entities.User;
import gr.careplus4.models.Response;
import gr.careplus4.repositories.UserRepository;
import gr.careplus4.services.iRoleService;
import gr.careplus4.services.iUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/v1/api/user")
public class UserAPIController {
    @Autowired
    private iUserService userService;

    @Autowired
    private iRoleService roleService;

    private final BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();

    @GetMapping
    public ResponseEntity<?> getAllUsers() {
        return new ResponseEntity<Response>(new Response(true, "Get all users successfully", userService.findAll()), HttpStatus.OK);
    }

    @PostMapping(path = "/getUser")
    public ResponseEntity<?> getUsers(@Validated @RequestParam("phoneNumber") String phoneNumber) {
        Optional<User> user = userService.findByPhoneNumber(phoneNumber);

        if (user.isPresent()) {
            return new ResponseEntity<Response>(new Response(true, "Get user successfully", user.get()), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false, "User not found", null), HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/getUserByEmail")
    public ResponseEntity<?> getUserByEmail(@Validated @RequestParam("email") String email) {
        Optional<User> user = userService.findByEmail(email);

        if (user.isPresent()) {
            return new ResponseEntity<Response>(new Response(true, "Get user successfully", user.get()), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false, "User not found", null), HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(path = "/getUserByNameContaining")
    public ResponseEntity<?> getUserByNameContaining(@Validated @RequestParam("name") String name, Pageable pageable) {
        Page<User> users = userService.findByNameContaining(name, pageable);
        if(users.isEmpty()){
            return new ResponseEntity<Response>(new Response(false, "User not found", null), HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<Response>(new Response(true, "Get users successfully", users.getContent()), HttpStatus.OK);
    }

    @PostMapping(path = "/getUserByRole")
    public ResponseEntity<?> getUserByRole(@Validated @RequestParam("idrole") int role, Pageable pageable) {
        Optional<Role> roleOptional = roleService.findById(role);
        Page<User> users = userService.findByRoleName(roleOptional.get().getName(), pageable);
        if(users.isEmpty()){
            return new ResponseEntity<Response>(new Response(false, "User not found", null), HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<Response>(new Response(true, "Get users successfully", users.getContent()), HttpStatus.OK);
    }

    @PostMapping(path = "/getUserLogin")
    public ResponseEntity<?> getUserLogin(@Validated @RequestParam("phoneNumber") String phoneNumber,
                                          @Validated @RequestParam("password") String password) {
        Optional<User> user = userService.findByPhoneNumber(phoneNumber);

        if (!user.isPresent() || !bCryptPasswordEncoder.matches(password, user.get().getPassword())) {
            return new ResponseEntity<>(new Response(false, "User not found or incorrect password", null), HttpStatus.NOT_FOUND);
        }

        // Trả về JSON thông báo đăng nhập thành công
        return new ResponseEntity<>(new Response(true, "Login successful", null), HttpStatus.OK);
    }

    @PostMapping(path = "/addUser")
    public ResponseEntity<?> addUser(@Validated @RequestParam("phoneNumber") String phoneNumber,
                                     @Validated @RequestParam("name") String name,
                                     @Validated @RequestParam("address") String address,
                                     @Validated @RequestParam("gender") String gender,
                                     @Validated @RequestParam("email") String email,
                                     @Validated @RequestParam("role") int role,
                                     @Validated @RequestParam("password") String password){
        Optional<User> user = userService.findByPhoneNumber(phoneNumber);

        if (user.isPresent() || userService.emailExists(email)) {
            return new ResponseEntity<Response>(new Response(false, "User / Email already exists", null), HttpStatus.CONFLICT);
        }

        Optional<Role> roleOptional = roleService.findById(role);

        User newUser = new User();
        newUser.setPhoneNumber(phoneNumber);
        newUser.setName(name);
        newUser.setAddress(address);
        newUser.setGender(gender);
        newUser.setEmail(email);
        newUser.setRole(roleOptional.get());
        newUser.setActive(true);
        newUser.setPassword(bCryptPasswordEncoder.encode(password));

        userService.save(newUser);
        return new ResponseEntity<Response>(new Response(true, "Add user successfully", newUser), HttpStatus.CREATED);
    }

    @PutMapping(path = "/updateUser")
    public ResponseEntity<?> updateUser(@Validated @RequestParam("phoneNumber") String phoneNumber,
                                        @Validated @RequestParam("name") String name,
                                        @Validated @RequestParam("address") String address,
                                        @Validated @RequestParam("gender") String gender,
                                        @Validated @RequestParam("email") String email,
                                        @Validated @RequestParam("role") int role){
        Optional<User> user = userService.findByPhoneNumber(phoneNumber);

        if (!user.isPresent()) {
            return new ResponseEntity<Response>(new Response(false, "User not found", null), HttpStatus.NOT_FOUND);
        }

        Optional<Role> roleOptional = roleService.findById(role);

        user.get().setName(name);
        user.get().setAddress(address);
        user.get().setGender(gender);
        user.get().setEmail(email);
        user.get().setRole(roleOptional.get());

        userService.save(user.get());
        return new ResponseEntity<Response>(new Response(true, "Update user successfully", user.get()), HttpStatus.OK);
    }

    @PutMapping(path = "/updatePassword")
    public ResponseEntity<?> updatePassword(@Validated @RequestParam("phoneNumber") String phoneNumber,
                                            @Validated @RequestParam("currentPassword") String currentPassword,
                                            @Validated @RequestParam("newPassword") String newPassword){
        Optional<User> user = userService.findByPhoneNumber(phoneNumber);

        if (!user.isPresent()) {
            return new ResponseEntity<Response>(new Response(false, "User not found", null), HttpStatus.NOT_FOUND);
        }

        if (!bCryptPasswordEncoder.matches(currentPassword, user.get().getPassword())) {
            return new ResponseEntity<Response>(new Response(false, "Current password is incorrect", null), HttpStatus.BAD_REQUEST);
        }

        user.get().setPassword(bCryptPasswordEncoder.encode(newPassword));

        userService.save(user.get());
        return new ResponseEntity<Response>(new Response(true, "Update password successfully", user.get()), HttpStatus.OK);
    }

    @DeleteMapping(path = "/deleteUser")
    public ResponseEntity<?> deleteUser(@Validated @RequestParam("phoneNumber") String phoneNumber){
        Optional<User> user = userService.findByPhoneNumber(phoneNumber);

        if (!user.isPresent()) {
            return new ResponseEntity<Response>(new Response(false, "User not found", null), HttpStatus.NOT_FOUND);
        }

        userService.delete(user.get());
        return new ResponseEntity<Response>(new Response(true, "Delete user successfully", null), HttpStatus.OK);
    }
}
