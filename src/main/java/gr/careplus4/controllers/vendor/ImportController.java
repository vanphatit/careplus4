package gr.careplus4.controllers.vendor;

import gr.careplus4.entities.Import;
import gr.careplus4.models.EventModel;
import gr.careplus4.models.ImportModel;
import gr.careplus4.services.impl.ImportServiceImpl;
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
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("vendor/import")
public class ImportController {
    @Autowired
    ImportServiceImpl importService;

//    @Autowired
//    ProviderService providerService; // Service lấy danh sách Provider
//
//    @ModelAttribute("providers")
//    public List<Provider> getProviders() {
//        return providerService.findAll(); // Lấy danh sách providers
//    }
    @RequestMapping("")
    public String all(Model model, @RequestParam("page") Optional<Integer> page,
                      @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = 10;

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id")); // Thay đổi nếu cần
        Page<Import> importPage = importService.findAll(pageable); // Lấy đối tượng Page<Event>

        model.addAttribute("importPage", importPage); // Truyền eventPage vào model
        model.addAttribute("imports", importPage.getContent());

        int totalPages = importPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        return "vendor/import-list";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new java.beans.PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                if (text == null || text.trim().isEmpty()) {
                    setValue(null); // Gán null nếu giá trị rỗng hoặc không có
                } else {
                    try {
                        setValue(dateFormat.parse(text)); // Chuyển đổi chuỗi thành Date
                    } catch (Exception e) {
                        setValue(null); // Gán null nếu giá trị không hợp lệ
                    }
                }
            }
        });
    }

//    @GetMapping("/add")
//    public String add(Model model) {
//        ImportModel imp = new ImportModel();
//        model.addAttribute("imp", imp);
//        return "vendor/import-add";
//    }
//
//    @PostMapping("/save")
//    public ModelAndView save(ModelMap model, @Valid @ModelAttribute("imp") ImportModel importModel,
//                             BindingResult result) {
//        if (result.hasErrors()) {
//            System.out.println("Errors: " + result.getAllErrors());
//            return new ModelAndView("vendor/import-add");
//        }
//        Import entity = new Import();
//        BeanUtils.copyProperties(importModel, entity);
//        importService.save(entity);
//        String message = "Import added successfully";
//        model.addAttribute("message", message);
//        return new ModelAndView("redirect:/vendor/import", model);
//
//    }
//
//    @GetMapping("/edit/{id}")
//    public ModelAndView edit(ModelMap model, @PathVariable("id") String id) {
//        Optional<Import> optionalImport = importService.findById(id);
//        ImportModel imp = new ImportModel();
//        if (optionalImport.isPresent()) {
//            Import entity = optionalImport.get();
//            BeanUtils.copyProperties(entity, imp);
//            model.addAttribute("imp", imp);
//            return new ModelAndView("vendor/import-add", model);
//        }
//        model.addAttribute("mess", "Import not found");
//        return new ModelAndView("forward:/vendor/import-list", model);
//    }
//
//    @GetMapping("/delete/{id}")
//    public String confirmDelete(Model model, @PathVariable("id") String id) {
//        Optional<Import> optionalImport = importService.findById(id);
//        if (optionalImport.isPresent()) {
//            model.addAttribute("event", optionalImport.get());
//            return "vendor/import-delete"; // Hiển thị trang xác nhận xóa
//        }
//        return "redirect:/vendor/import";
//    }
//
//    @PostMapping("/delete/{id}")
//    public String delete(@PathVariable("id") String id) {
//        importService.deleteById(id);
//        return "redirect:/vendor/import";
//    }

    @RequestMapping("/searchpaginated")
    public String searchById(ModelMap model,
                         @RequestParam(name = "id", required = false) String id,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {

        int currentPage = page.orElse(1);
        int pageSize = 10;

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id")); // Sửa Sort theo id

        Page<Import> resultPage;
        if (StringUtils.hasText(id)) {
            resultPage = importService.findById(id, pageable);
            model.addAttribute("id", id);
        }
        else {
            resultPage = importService.findAll(pageable);
        }

        model.addAttribute("importPage", resultPage);// Truyền eventPage vào model
        model.addAttribute("imports", resultPage.getContent());

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        return "vendor/import-list";
    }

}
