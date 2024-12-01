package gr.careplus4.controllers.user;

import gr.careplus4.entities.User;
import gr.careplus4.services.impl.UserServiceImpl;
import gr.careplus4.services.security.JwtCookies;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class UserInfoController {

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private JwtCookies jwtCookies;

    private final PasswordEncoder passwordEncoder;

    public UserInfoController(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/userInfo")
    public String userInfo(Model model, HttpServletRequest request) {
        String phoneNumber = jwtCookies.getUserPhoneFromJwt(request);
        User user = userService.findByPhoneNumber(phoneNumber).orElse(null);
        model.addAttribute("user", user);
        return "user/userInfo";
    }

    @GetMapping("/updateProfile")
    public String editUserInfo(Model model, HttpServletRequest request) {
        String phoneNumber = jwtCookies.getUserPhoneFromJwt(request);
        User user = userService.findByPhoneNumber(phoneNumber).orElse(null);
        model.addAttribute("user", user);
        return "user/updateProfile";
    }

    @PostMapping("/updateProfile")
    public String updateUserInfo(@RequestParam("name") String name,
                                 @RequestParam("address") String address,
                                 @RequestParam("gender") String gender, HttpServletRequest request) {

        System.out.println("name: " + name + " address" + address + "gender" + gender);

        String phoneNumber = jwtCookies.getUserPhoneFromJwt(request);
        User userToUpdate = userService.findByPhoneNumber(phoneNumber).orElse(null);

        System.out.println(userToUpdate.toString());
        userToUpdate.setName(name);
        userToUpdate.setAddress(address);
        userToUpdate.setGender(gender);
        userService.save(userToUpdate);
        return "redirect:/user/userInfo";
    }

    @GetMapping("/changePassword")
    public String changePassword() {
        return "user/changePassword";
    }

    @PostMapping("/changePassword")
    public String changePassword(@RequestParam("password") String password,
                                 @RequestParam("repassword") String rePassword,
                                 HttpServletRequest request, Model model) {
        String phoneNumber = jwtCookies.getUserPhoneFromJwt(request);
        User user = userService.findByPhoneNumber(phoneNumber).orElse(null);

        if(password.isEmpty() || rePassword.isEmpty()) {
            model.addAttribute("error", 2);
            return "redirect:/user/changePassword";
        }

        if (!password.equals(rePassword)) {
            model.addAttribute("error", 1);
            return "redirect:/user/changePassword";
        }
        user.setPassword(passwordEncoder.encode(password));
        userService.save(user);
        return "redirect:/user/userInfo";
    }
}
