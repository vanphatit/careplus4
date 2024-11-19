package gr.careplus4.controllers.admin.provider;

import gr.careplus4.entities.Provider;
import gr.careplus4.models.ProviderModel;
import gr.careplus4.services.impl.ProviderServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("admin/provider")
public class ProviderController {
    @Autowired
    ProviderServiceImpl providerService;

    @RequestMapping("")
    public String all(Model model, @RequestParam("page") Optional<Integer> page,
                      @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id")); // Thay đổi nếu cần
        Page<Provider> providerPage = providerService.findAll(pageable); // Lấy đối tượng Page<Provider>

        model.addAttribute("providerPage", providerPage); // Truyền providerPage vào model
        model.addAttribute("providers", providerPage.getContent());

        int totalPages = providerPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        return "admin/provider-list";
    }

    @GetMapping("/add")
    public String add(Model model) {
        ProviderModel pro = new ProviderModel();
        model.addAttribute("pro", pro);
        return "admin/provider-add";
    }

    @PostMapping("/save")
    public ModelAndView save(ModelMap model, @Valid @ModelAttribute("pro") ProviderModel providerModel,
                             BindingResult result) {
        if (result.hasErrors()) {
            System.out.println("Errors: " + result.getAllErrors());
            return new ModelAndView("admin/provider-add");
        }
        Provider entity = new Provider();
        BeanUtils.copyProperties(providerModel, entity);
        entity.setId(null); // Đặt lại để chắc chắn ID được tự động generate
        providerService.save(entity);
        String message = "Provider added successfully";
        model.addAttribute("message", message);
        return new ModelAndView("redirect:/admin/provider", model);

    }

    @GetMapping("/edit/{id}")
    public ModelAndView edit(ModelMap model, @PathVariable("id") String id) {
        Optional<Provider> optionalProvider = providerService.findById(id);
        ProviderModel pro = new ProviderModel();
        if (optionalProvider.isPresent()) {
            Provider entity = optionalProvider.get();
            BeanUtils.copyProperties(entity, pro);
            model.addAttribute("pro", pro);
            return new ModelAndView("admin/provider-add", model);
        }
        model.addAttribute("mess", "Provider not found");
        return new ModelAndView("forward:/admin/provider-list", model);
    }

    @GetMapping("/delete/{id}")
    public String confirmDelete(Model model, @PathVariable("id") String id) {
        Optional<Provider> optionalProvider = providerService.findById(id);
        if (optionalProvider.isPresent()) {
            model.addAttribute("pro", optionalProvider.get());
            return "admin/provider-delete"; // Hiển thị trang xác nhận xóa
        }
        return "redirect:/admin/provider";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") String id) {
        providerService.deleteById(id);
        return "redirect:/admin/provider";
    }

    @RequestMapping("/searchpaginated")
    public String search(ModelMap model,
                         @RequestParam(name="name", required = false) String name,
                         @RequestParam(name = "id", required = false) String id,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id")); // Sửa Sort theo id

        Page<Provider> resultPage;
        if (StringUtils.hasText(name)) {
            resultPage = providerService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        } else if (StringUtils.hasText(id)) {
            resultPage = providerService.findByIdContaining(id, pageable);
            model.addAttribute("id", id);
        }
        else {
            resultPage = providerService.findAll(pageable);
        }

        model.addAttribute("providerPage", resultPage);// Truyền providerPage vào model
        model.addAttribute("providers", resultPage.getContent());

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        return "admin/provider-list";
    }

    @GetMapping("/show/{id}")
    public ModelAndView show(ModelMap model, @PathVariable("id") String id) {
        Optional<Provider> optionalProvider = providerService.findById(id);
        if (optionalProvider.isPresent()) {
            Provider provider = optionalProvider.get();
            model.addAttribute("provider", provider); // Truyền dữ liệu provider sang view
            return new ModelAndView("admin/provider-show", model); // Hiển thị trang chi tiết provider
        }
        model.addAttribute("mess", "Provider not found");
        return new ModelAndView("redirect:/admin/provider", model); // Quay lại danh sách nếu không tìm thấy
    }

}