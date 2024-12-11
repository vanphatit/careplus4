package gr.careplus4.controllers.vendor;

import gr.careplus4.entities.Import;
import gr.careplus4.entities.ImportDetail;
import gr.careplus4.entities.Medicine;
import gr.careplus4.entities.Provider;
import gr.careplus4.models.ImportDetailModel;
import gr.careplus4.models.ImportModel;
import gr.careplus4.services.impl.ImportDetailServiceImpl;
import gr.careplus4.services.impl.ImportServiceImpl;
import gr.careplus4.services.impl.MedicineServicesImpl;
import gr.careplus4.services.impl.ProviderServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cglib.core.Local;
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
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("vendor/import")
public class ImportController {
    @Autowired
    ImportServiceImpl importService;

    @Autowired
    ImportDetailServiceImpl importDetailService;

    @Autowired
    ProviderServiceImpl providerService; // Service lấy danh sách Provider

    @ModelAttribute("providers")
    public List<Provider> getProviders() {
        return providerService.findAll(); // Lấy danh sách providers
    }
    @RequestMapping("")
    public ModelAndView all(ModelMap model, @RequestParam("page") Optional<Integer> page,
                      @RequestParam(value = "error", required = false) String error,
                      @RequestParam(value = "message", required = false) String message,
                      @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = 10;

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("date").descending()); // Thay đổi nếu cần
        Page<Import> importPage = importService.findAll(pageable); // Lấy đối tượng Page<Import>

        model.addAttribute("importPage", importPage); // Truyền importPage vào model
        model.addAttribute("imports", importPage.getContent());

        int totalPages = importPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        model.addAttribute("error", error);
        model.addAttribute("message", message);
        return new ModelAndView("vendor/import/import-list", model);
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

    @GetMapping("/add")
    public String add(Model model) {
        List<Provider> providers = providerService.findAll();
        if (providers.isEmpty()) {
            model.addAttribute("error", "Không có Provider nào, vui lòng thêm Provider trước khi tạo Import!");
            return "vendor/import/import-list"; // Hoặc điều hướng đến một trang khác
        }
        LocalDate now = LocalDate.now();
        ImportModel imp = new ImportModel();
        model.addAttribute("now", java.sql.Date.valueOf(now));
        model.addAttribute("imp", imp);
        return "vendor/import/import-add";
    }

    @PostMapping("/save")
    public ModelAndView save(ModelMap model, @Valid @ModelAttribute("imp") ImportModel importModel,

                             BindingResult result) {
        if (result.hasErrors()) {
            System.out.println("Errors: " + result.getAllErrors());
            return new ModelAndView("vendor/import/import-add");
        }
        // Kiểm tra xem Provider có tồn tại không
        if (!providerService.existsById(importModel.getProviderId())) {
            model.addAttribute("error", "Provider không tồn tại!");
            return new ModelAndView("vendor/import/import-add", model);
        }
        // Lấy thực thể Provider từ providerId
        Provider provider = providerService.findById(importModel.getProviderId()).orElse(null);
        if (provider == null) {
            model.addAttribute("error", "Provider không tồn tại!");
            return new ModelAndView("vendor/import/import-add", model);
        }

        // Tạo mới Import và ánh xạ dữ liệu
        Import entity = new Import();
        BeanUtils.copyProperties(importModel, entity);
        entity.setProvider(provider); // Gán thực thể Provider vào Import

        importService.save(entity); // Lưu Import
        model.addAttribute("message", "Đã lưu Import thành công!");
        return new ModelAndView("redirect:/vendor/import", model);
    }


    @GetMapping("/edit/{id}")
    public ModelAndView edit(ModelMap model, @PathVariable("id") String id) {
        Optional<Import> optionalImport = importService.findById(id);
        ImportModel imp = new ImportModel();
        if (optionalImport.isPresent()) {
            Import entity = optionalImport.get();
            BeanUtils.copyProperties(entity, imp);
            // Kiểm tra Provider tồn tại
            if (!providerService.existsById(entity.getProvider().getId())) {
                model.addAttribute("error", "Provider không tồn tại cho Import này!");
                return new ModelAndView("vendor/import/import-list", model);
            }
            model.addAttribute("imp", imp);
            return new ModelAndView("vendor/import/import-add", model);
        }
        model.addAttribute("error", "Không tìm thấy Import!");
        return new ModelAndView("forward:/vendor/import/import-list", model);
    }

    @GetMapping("/delete/{id}")
    public ModelAndView confirmDelete(ModelMap model, @PathVariable("id") String id) {
        Optional<Import> optionalImport = importService.findById(id);
        if (optionalImport.isPresent()) {
            model.addAttribute("imp", optionalImport.get());
            Boolean hasImportDetail = importDetailService.existsImportDetailByImportId(id);
            if (hasImportDetail) {
                model.addAttribute("error", "Không thể xóa Import đã có chi tiết Import!");
                return new ModelAndView("redirect:/vendor/import", model);
            }
            model.addAttribute("hasImportDetail", hasImportDetail);
            return new ModelAndView("vendor/import/import-delete", model);
        }
        return new ModelAndView("redirect:/vendor/import", model);
    }

    @PostMapping("/delete/{id}")
    public ModelAndView delete(ModelMap model,@PathVariable("id") String id) {
        if (importDetailService.existsImportDetailByImportId(id)) {
            model.addAttribute("error", "Không thể xóa Import đã có chi tiết Import!");
            return new ModelAndView("redirect:/vendor/import", model);
        }
        importService.deleteById(id);
        model.addAttribute("message", "Đã xóa Import thành công!");
        return new ModelAndView("redirect:/vendor/import", model);
    }

    @RequestMapping("/searchpaginated")
    public String searchByIdOrProviderId(ModelMap model,
                         @RequestParam(name = "id", required = false) String id,
                         @RequestParam(name = "providerId", required = false) String providerId,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {

        int currentPage = page.orElse(1);
        int pageSize = 10;

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id")); // Sửa Sort theo id

        Page<Import> resultPage;
        if (StringUtils.hasText(id)) {
            resultPage = importService.findByIdContaining(id, pageable);
            model.addAttribute("id", id);
        }
        else if (StringUtils.hasText(providerId)) {
            // Tìm kiếm theo ID Provider
            resultPage = importService.findByProviderIdContaining(providerId, pageable);
            model.addAttribute("providerId", providerId);
        }
        else {
            resultPage = importService.findAll(pageable);
        }

        model.addAttribute("importPage", resultPage);// Truyền importPage vào model
        model.addAttribute("imports", resultPage.getContent());

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        return "vendor/import/import-list";
    }

    @GetMapping("/show/{id}")
    public String showImportDetails(@PathVariable("id") String id, Model model) {
        Optional<Import> optionalImport = importService.findById(id);
        if (optionalImport.isPresent()) {
            Import importEntity = optionalImport.get();
            List<ImportDetail> details = importDetailService.findImportDetailByImportId(id);

            model.addAttribute("importDetails", details);
            model.addAttribute("importEntity", importEntity);
            return "vendor/import/import-details"; // Giao diện hiển thị chi tiết Import
        }
        model.addAttribute("error", "Import not found");
        return "vendor/import/import-list"; // Quay lại danh sách nếu không tìm thấy Import
    }
}
