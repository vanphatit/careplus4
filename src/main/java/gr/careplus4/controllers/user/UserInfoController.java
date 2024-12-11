package gr.careplus4.controllers.user;

import gr.careplus4.entities.User;
import gr.careplus4.services.impl.UserServiceImpl;
import gr.careplus4.services.security.JwtCookies;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
    public String userInfo(Model model, @RequestParam(value = "error", required = false) String error,
                           @RequestParam(value = "success", required = false) String success,
                           HttpServletRequest request) {
        String phoneNumber = jwtCookies.getUserPhoneFromJwt(request);
        User user = userService.findByPhoneNumber(phoneNumber).orElse(null);
        model.addAttribute("user", user);

        if (error != null) {
            model.addAttribute("error", "Có lỗi xảy ra, vui lòng thử lại sau");
        }
        if (success != null) {
            model.addAttribute("success", "Cập nhật thông tin thành công");
        }

        return "user/userInfo";
    }

    @GetMapping("/updateProfile")
    public String editUserInfo(Model model, HttpServletRequest request,
                               @RequestParam(value = "error", required = false) String error) {
        String phoneNumber = jwtCookies.getUserPhoneFromJwt(request);
        User user = userService.findByPhoneNumber(phoneNumber).orElse(null);
        model.addAttribute("user", user);
        return "user/updateProfile";
    }

    @PostMapping("/updateProfile")
    public ModelAndView updateUserInfo(@RequestParam("name") String name, ModelMap model,
                                       @RequestParam("address") String address,
                                       @RequestParam("gender") String gender, HttpServletRequest request) {

        System.out.println("name: " + name + " address" + address + "gender" + gender);

        try{
            String phoneNumber = jwtCookies.getUserPhoneFromJwt(request);
            User userToUpdate = userService.findByPhoneNumber(phoneNumber).orElse(null);

            System.out.println(userToUpdate.toString());
            userToUpdate.setName(name);
            userToUpdate.setAddress(address);
            userToUpdate.setGender(gender);
            userService.save(userToUpdate);
            model.addAttribute("success", "Cập nhật thông tin thành công");
            return new ModelAndView("redirect:/user/userInfo", model);
        } catch (Exception e) {
            model.addAttribute("error", "Có lỗi xảy ra, vui lòng thử lại sau");
            return new ModelAndView("redirect:/user/updateProfile", model);
        }
    }

    @GetMapping("/changePassword")
    public String changePassword(@RequestParam(value = "error", required = false) String error, Model model) {
        if (error != null) {
            model.addAttribute("error", "Mật khẩu không trùng khớp");
        }
        return "user/changePassword";
    }

    @PostMapping("/changePassword")
    public ModelAndView changePassword(@RequestParam("password") String password,
                                 @RequestParam("repassword") String rePassword,
                                 HttpServletRequest request, ModelMap model) {
        String phoneNumber = jwtCookies.getUserPhoneFromJwt(request);
        User user = userService.findByPhoneNumber(phoneNumber).orElse(null);

        if(password.isEmpty() || rePassword.isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập mật khẩu");
            return new ModelAndView("redirect:/user/changePassword", model);
        }

        if (!password.equals(rePassword)) {
            model.addAttribute("error", "Mật khẩu không trùng khớp");
            return new ModelAndView("redirect:/user/changePassword", model);
        }
        user.setPassword(passwordEncoder.encode(password));
        userService.save(user);
        model.addAttribute("success", "Đổi mật khẩu thành công");
        return new ModelAndView("redirect:/user/userInfo", model);
    }
}
