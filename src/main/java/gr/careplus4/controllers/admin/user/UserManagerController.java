package gr.careplus4.controllers.admin.user;

import gr.careplus4.entities.User;
import gr.careplus4.services.impl.RoleServiceImpl;
import gr.careplus4.services.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin")
public class UserManagerController {

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private RoleServiceImpl roleService;

    private final PasswordEncoder passwordEncoder;

    public UserManagerController(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/users")
    public String showUsers(Model model, @RequestParam("page") Optional<Integer> page,
                            @Validated @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(15);

        Pageable pageable = (Pageable) PageRequest.of(currentPage - 1, pageSize, Sort.by("updatedAt").descending());
        Page<User> users = userService.findAll(pageable);

        model.addAttribute("usersPage", users);

        int totalPages = users.getTotalPages();
        if (totalPages > 0) {
            model.addAttribute("pageNo", totalPages);
        }
        model.addAttribute("currentPage", currentPage);

        return "admin/user/user-list";
    }

    @PostMapping("/user/search")
    public String searchUsers(@RequestParam("searchT") String text, @RequestParam("page") Optional<Integer> page,
                              @Validated @RequestParam("size") Optional<Integer> size, Model model) {

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(15);

        Pageable pageable = (Pageable) PageRequest.of(currentPage - 1, pageSize, Sort.by("updatedAt").descending());
        Page<User> users = userService.findByNameContainingIgnoreCaseOrPhoneNumber(text, text, pageable);

        model.addAttribute("usersPage", users);

        int totalPages = users.getTotalPages();
        if (totalPages > 0) {
            model.addAttribute("pageNo", totalPages);
        }
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("seachText", text);
        return "admin/user/user-list";
    }

    @GetMapping("/user/new")
    public String newUser(Model model, @RequestParam(value = "errorMessage", required = false) String error,
                                @RequestParam(value = "successMessage", required = false) String success) {
        if (error != null)
            model.addAttribute("errorMessage", error);
        if (success != null)
            model.addAttribute("successMessage", success);
        return "admin/user/user-create";
    }

    @PostMapping("/user/new")
    public ModelAndView createUser(
            @RequestParam("phoneNumber") String phoneNumber,
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("address") String address,
            @RequestParam("gender") String gender,
            @RequestParam("role") String role,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword,
            ModelMap model) {

        // Kiểm tra mật khẩu khớp nhau
        if (!password.equals(confirmPassword)) {
            model.addAttribute("errorMessage", "Mật khẩu và xác nhận mật khẩu không khớp!");
            return new ModelAndView("redirect:/admin/user/new", model);
        }

        // Kiểm tra email tồn tại
        if (userService.findByEmail(email).isPresent()) {
            model.addAttribute("errorMessage", "Email đã được sử dụng!");
            return new ModelAndView("redirect:/admin/user/new", model);
        }

        // Kiểm tra số điện thoại tồn tại
        if (userService.findByPhoneNumber(phoneNumber).isPresent()) {
            model.addAttribute("errorMessage", "Số điện thoại đã được sử dụng!");
            return new ModelAndView("redirect:/admin/user/new", model);
        }

        try{
            // Tạo mới user
            User user = new User();
            user.setPhoneNumber(phoneNumber);
            user.setName(name);
            user.setAddress(address);
            user.setPassword(passwordEncoder.encode(password));
            user.setGender(gender);
            user.setEmail(email);
            user.setRole(roleService.findByName(role).get());
            user.setCreatedAt(Date.from(new Date().toInstant()));
            user.setUpdatedAt(Date.from(new Date().toInstant()));
            user.setStatus(true);
            user.setPointEarned(0);
            user.setStatus(true);

            // Lưu vào cơ sở dữ liệu
            userService.save(user);

            model.addAttribute("successMessage", "Tạo người dùng thành công!");
            return new ModelAndView("redirect:/admin/users", model);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Lỗi tạo người dùng!");
            return new ModelAndView("redirect:/admin/user/new", model);
        }
    }

    @GetMapping("/user/delete/{phoneNumber}")
    public ModelAndView deleteUser(@PathVariable("phoneNumber") String phoneNumber) {
        User user = userService.findByPhoneNumber(phoneNumber).get();
        user.setStatus(false);
        userService.save(user);
        return new ModelAndView("redirect:/admin/users");
    }

    @GetMapping("/user/activate/{phoneNumber}")
    public ModelAndView activateUser(@PathVariable("phoneNumber") String phoneNumber) {
        User user = userService.findByPhoneNumber(phoneNumber).get();
        user.setStatus(true);
        userService.save(user);
        return new ModelAndView("redirect:/admin/users");
    }

    @GetMapping("/user/{phoneNumber}")
    public String editUser(@PathVariable("phoneNumber") String phoneNumber, Model model) {
        User user = userService.findByPhoneNumber(phoneNumber).get();
        model.addAttribute("userGet", user);
        return "admin/user/user-detail";
    }

    @GetMapping("/user/update/{phoneNumber}")
    public String updateUser(@PathVariable("phoneNumber") String phoneNumber, Model model) {
        User user = userService.findByPhoneNumber(phoneNumber).get();
        model.addAttribute("userGet", user);
        return "admin/user/user-update";
    }

    @PostMapping("/user/update/{phoneNumber}")
    public ModelAndView updateUser(Model model, @PathVariable("phoneNumber") String phoneNumber,
                                   @RequestParam("name") String name, @RequestParam("email") String email,
                                   @RequestParam("address") String address, @RequestParam("gender") String gender,
                                   @RequestParam("pointEarned") int pointEarned, @RequestParam("role") String roleName) {
        try {
            User user1 = userService.findByPhoneNumber(phoneNumber).get();
            user1.setName(name);
            user1.setGender(gender);
            user1.setEmail(email);
            user1.setRole(roleService.findByName(roleName).get());
            user1.setAddress(address);
            user1.setPointEarned(pointEarned);
            userService.save(user1);
            model.addAttribute("success", "User updated successfully");
        } catch (Exception e) {
            model.addAttribute("error", "Error updating user");
        }

        return new ModelAndView("redirect:/admin/user/" + phoneNumber);
    }

    @GetMapping("/user/newpass/{phoneNumber}")
    public ModelAndView updatePasswordForUser(@PathVariable("phoneNumber") String phoneNumber, Model model) {
        try {
            User user = userService.findByPhoneNumber(phoneNumber).get();
            user.setPassword(passwordEncoder.encode("123456"));
            userService.save(user);
            model.addAttribute("success", "Password updated successfully");
        } catch (Exception e) {
            model.addAttribute("error", "Error updating password");
        }
        return new ModelAndView("redirect:/admin/user/" + phoneNumber);
    }

}
