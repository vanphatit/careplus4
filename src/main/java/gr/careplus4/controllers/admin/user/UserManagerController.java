package gr.careplus4.controllers.admin.user;

import com.nimbusds.oauth2.sdk.http.HTTPEndpoint;
import gr.careplus4.entities.User;
import gr.careplus4.services.impl.RoleServiceImpl;
import gr.careplus4.services.impl.UserServiceImpl;
import gr.careplus4.services.security.JwtCookies;
import jakarta.servlet.http.HttpServletRequest;
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

import java.util.ArrayList;
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
    @Autowired
    private JwtCookies jwtCookies;

    public UserManagerController(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/users")
    public String showUsers(Model model, @RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "success", required = false) String success,
                            @RequestParam("page") Optional<Integer> page,
                            @Validated @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        int adminCount = 0, vendorCount = 0, userCount = 0;

        Pageable pageable = (Pageable) PageRequest.of(currentPage - 1, pageSize, Sort.by("updatedAt").descending());
        Page<User> users = userService.findAll(pageable);

        for(User user : userService.findAll()) {
            if(user.getRole().getName().equalsIgnoreCase("admin")) {
                adminCount++;
            } else if(user.getRole().getName().equalsIgnoreCase("vendor")) {
                vendorCount++;
            } else {
                userCount++;
            }
        }

        model.addAttribute("usersPage", users);

        int totalPages = users.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = generatePageNumbers(currentPage, totalPages);
            model.addAttribute("pageNumbers", pageNumbers);
        }
        model.addAttribute("adminCount", adminCount);
        model.addAttribute("vendorCount", vendorCount);
        model.addAttribute("userCount", userCount);

        model.addAttribute("currentPage", currentPage);
        model.addAttribute("pageSize", pageSize);

        if(error != null) {
            model.addAttribute("error", error);
        }
        if(success != null) {
            model.addAttribute("success", success);
        }

        return "admin/user/user-list";
    }

    @PostMapping("/user/search")
    public String searchUsers(@RequestParam("searchT") String text, @RequestParam("page") Optional<Integer> page,
                              @Validated @RequestParam("size") Optional<Integer> size, Model model) {

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        if (text.isEmpty()) {
            return "redirect:/admin/users";
        }

        Pageable pageable = (Pageable) PageRequest.of(currentPage - 1, pageSize, Sort.by("updatedAt").descending());
        Page<User> users = userService.findByNameContainingIgnoreCaseOrPhoneNumber(text, text, pageable);

        String searchCount = " ( " + users.getTotalElements() + " kết quả tìm kiếm)";

        model.addAttribute("usersPage", users);

        int totalPages = users.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = generatePageNumbers(currentPage, totalPages);
            model.addAttribute("pageNumbers", pageNumbers);
        }
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("pageSize", pageSize);

        model.addAttribute("searchText", text);
        model.addAttribute("searchCount", searchCount);
        return "admin/user/user-list";
    }

    @GetMapping("/users/filter")
    public String filterUsersByRole(@RequestParam(value = "roles", required = false) String roleName,
                                    @RequestParam(value = "status", required = false) String status,
                                    @RequestParam("page") Optional<Integer> page,
                                    @Validated @RequestParam("size") Optional<Integer> size, Model model) {

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = (Pageable) PageRequest.of(currentPage - 1, pageSize, Sort.by("updatedAt").descending());

        if("all".equalsIgnoreCase(roleName) && "all".equalsIgnoreCase(status)) {
            return "redirect:/admin/users";
        } else if(!"all".equalsIgnoreCase(roleName) && "all".equalsIgnoreCase(status)) { // filter by role
            Page<User> users = userService.findUsersByRole_Name(roleName, pageable);

            model.addAttribute("usersPage", users);

            int totalPages = users.getTotalPages();
            if (totalPages > 0) {
                List<Integer> pageNumbers = generatePageNumbers(currentPage, totalPages);
                model.addAttribute("pageNumbers", pageNumbers);
            }

            model.addAttribute("current_status", status);
            model.addAttribute("current_role", roleName);
            model.addAttribute("roleCount", users.getTotalElements());
        } else if(!"all".equalsIgnoreCase(status) && "all".equalsIgnoreCase(roleName)) { // filter by status
            boolean statusBool = true;
            if("inactive".equalsIgnoreCase(status)) {
                statusBool = false;
            }
            Page<User> users = userService.findUsersByStatus(statusBool, pageable);

            model.addAttribute("usersPage", users);

            int totalPages = users.getTotalPages();
            if (totalPages > 0) {
                List<Integer> pageNumbers = generatePageNumbers(currentPage, totalPages);
                model.addAttribute("pageNumbers", pageNumbers);
            }
            model.addAttribute("current_role", roleName);
            model.addAttribute("current_status", status);
            model.addAttribute("statusCount", users.getTotalElements());
        } else { // filter by both
            boolean statusBool = true;
            if("inactive".equalsIgnoreCase(status)) {
                statusBool = false;
            }
            Page<User> users = userService.findUsersByStatusAndRole_Name(statusBool, roleName, pageable);

            model.addAttribute("usersPage", users);

            int totalPages = users.getTotalPages();
            if (totalPages > 0) {
                List<Integer> pageNumbers = generatePageNumbers(currentPage, totalPages);
                model.addAttribute("pageNumbers", pageNumbers);
            }
            model.addAttribute("current_role", roleName);
            model.addAttribute("current_status", status);
            model.addAttribute("roleCount", users.getTotalElements());
            model.addAttribute("statusCount", users.getTotalElements());

        }
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("pageSize", pageSize);
        return "admin/user/user-list";
    }

    @GetMapping("/user/new")
    public String newUser(Model model, @RequestParam(value = "error", required = false) String error,
                                @RequestParam(value = "success", required = false) String success) {
        if (error != null)
            model.addAttribute("error", error);
        if (success != null)
            model.addAttribute("success", success);
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
            model.addAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp!");
            return new ModelAndView("redirect:/admin/user/new", model);
        }

        // Kiểm tra email tồn tại
        if (userService.findByEmail(email).isPresent()) {
            model.addAttribute("error", "Email đã được sử dụng!");
            return new ModelAndView("redirect:/admin/user/new", model);
        }

        // Kiểm tra số điện thoại tồn tại
        if (userService.findByPhoneNumber(phoneNumber).isPresent()) {
            model.addAttribute("error", "Số điện thoại đã được sử dụng!");
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

            model.addAttribute("success", "Tạo người dùng thành công!");
            return new ModelAndView("redirect:/admin/users", model);
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi tạo người dùng!");
            return new ModelAndView("redirect:/admin/user/new", model);
        }
    }

    @GetMapping("/user/delete/{phoneNumber}")
    public ModelAndView deleteUser(@PathVariable("phoneNumber") String phoneNumber, HttpServletRequest request, ModelMap model) {
        User user = userService.findByPhoneNumber(phoneNumber).get();
        String currentUser = jwtCookies.getUserPhoneFromJwt(request);
        if (user.getPhoneNumber().equals(currentUser)) {
            model.addAttribute("error", "Không thể tắt hoạt động tài khoản của chính mình!");
            return new ModelAndView("redirect:/admin/users", model);
        }
        user.setStatus(false);
        userService.save(user);
        model.addAttribute("success", "Tài khoản với SĐT: " + user.getPhoneNumber() + " đã được tắt hoạt động!");
        return new ModelAndView("redirect:/admin/users", model);
    }

    @GetMapping("/user/activate/{phoneNumber}")
    public ModelAndView activateUser(@PathVariable("phoneNumber") String phoneNumber, ModelMap model) {
        User user = userService.findByPhoneNumber(phoneNumber).get();
        user.setStatus(true);
        userService.save(user);
        model.addAttribute("success", "Tài khoản với SĐT: " + user.getPhoneNumber() + " đã được kích hoạt!");
        return new ModelAndView("redirect:/admin/users", model);
    }

    @GetMapping("/user/{phoneNumber}")
    public String editUser(@PathVariable("phoneNumber") String phoneNumber,
                           @RequestParam(value = "error", required = false) String error,
                           @RequestParam(value = "success", required = false) String success, Model model) {
        User user = userService.findByPhoneNumber(phoneNumber).get();
        model.addAttribute("userGet", user);

        if (error != null){
            model.addAttribute("error", error);
        }
        if (success != null){
            model.addAttribute("success", success);
        }

        return "admin/user/user-detail";
    }

    @GetMapping("/user/update/{phoneNumber}")
    public String updateUser(@PathVariable("phoneNumber") String phoneNumber,
                             @RequestParam(value = "error", required = false) String error,
                             @RequestParam(value = "success", required = false) String success,
                             Model model) {
        if (error != null){
            model.addAttribute("error", error);
        }
        if (success != null){
            model.addAttribute("success", success);
        }

        User user = userService.findByPhoneNumber(phoneNumber).get();
        model.addAttribute("userGet", user);
        return "admin/user/user-update";
    }

    @PostMapping("/user/update/{phoneNumber}")
    public ModelAndView updateUser(ModelMap model, @PathVariable("phoneNumber") String phoneNumber, HttpServletRequest request,
                                   @RequestParam("name") String name, @RequestParam("email") String email,
                                   @RequestParam("address") String address, @RequestParam("gender") String gender,
                                   @RequestParam("pointEarned") int pointEarned, @RequestParam("role") String roleName) {
        try {
            User user1 = userService.findByPhoneNumber(phoneNumber).get();
            user1.setName(name);
            user1.setGender(gender);
            user1.setEmail(email);

            if(user1.getRole().getName().equalsIgnoreCase("admin")
                    && jwtCookies.getUserPhoneFromJwt(request).equals(phoneNumber)) {
                model.addAttribute("error", "Không thể chuyển quyền của bản thân từ admin thành quyền khác!");
                return new ModelAndView("redirect:/admin/user/" + phoneNumber, model);
            }

            user1.setRole(roleService.findByName(roleName).get());
            user1.setAddress(address);
            user1.setPointEarned(pointEarned);
            userService.save(user1);
            model.addAttribute("success", "Cập nhật người dùng thành công!");
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi cập nhật người dùng!");
        }

        return new ModelAndView("redirect:/admin/user/" + phoneNumber, model);
    }

    @GetMapping("/user/newpass/{phoneNumber}")
    public ModelAndView updatePasswordForUser(@PathVariable("phoneNumber") String phoneNumber, ModelMap model) {
        try {
            User user = userService.findByPhoneNumber(phoneNumber).get();
            user.setPassword(passwordEncoder.encode("123456"));
            userService.save(user);
            model.addAttribute("success", "Mật khẩu đã được cập nhật thành 123456");
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi cập nhật mật khẩu!");
        }
        return new ModelAndView("redirect:/admin/user/" + phoneNumber, model);
    }

    // Phương thức tạo danh sách số trang hiển thị
    private List<Integer> generatePageNumbers(int currentPage, int totalPages) {
        List<Integer> pageNumbers = new ArrayList<>();

        if (totalPages <= 5) {
            // Nếu tổng số trang <= 5, hiển thị tất cả các trang
            for (int i = 1; i <= totalPages; i++) {
                pageNumbers.add(i);
            }
        } else {
            // Nếu tổng số trang > 5
            pageNumbers.add(1); // Trang đầu

            if (currentPage > 3) {
                pageNumbers.add(-1); // Thêm dấu "..." đại diện
            }

            // Thêm các trang lân cận
            for (int i = Math.max(2, currentPage - 1); i <= Math.min(totalPages - 1, currentPage + 1); i++) {
                pageNumbers.add(i);
            }

            if (currentPage < totalPages - 2) {
                pageNumbers.add(-1); // Thêm dấu "..." đại diện
            }

            pageNumbers.add(totalPages); // Trang cuối
        }

        return pageNumbers;
    }

}
