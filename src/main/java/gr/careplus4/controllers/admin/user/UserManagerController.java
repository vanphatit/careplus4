package gr.careplus4.controllers.admin.user;

import gr.careplus4.entities.User;
import gr.careplus4.services.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin")
public class UserManagerController {

    @Autowired
    private UserServiceImpl userService;

    @GetMapping("/users")
    public String showUsers(Model model,  @RequestParam("page") Optional<Integer> page,
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
}
