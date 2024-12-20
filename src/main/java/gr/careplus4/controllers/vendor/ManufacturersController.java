package gr.careplus4.controllers.vendor;

import gr.careplus4.entities.Manufacturer;
import gr.careplus4.models.ManufacturerModel;
import gr.careplus4.services.impl.ManufacturerServicesImpl;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/vendor")
public class ManufacturersController  {
    @Autowired
    private ManufacturerServicesImpl manufacturerService;

    public ManufacturersController(ManufacturerServicesImpl manufacturerService) {
        this.manufacturerService = manufacturerService;
    }

    @GetMapping("/manufacturers")
    public String getListManufacturers(Model model,
                                       @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                       @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize,
                                       @RequestParam(value = "error", required = false) String error,
                                       @RequestParam(value = "message", required = false) String message) {
        // Đảm bảo currentPage >= 1
        currentPage = Math.max(currentPage, 1);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
        Page<Manufacturer> manufacturers = manufacturerService.findAll(pageable);

        int totalPages = manufacturers.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        if (error != null) {
            model.addAttribute("error", error);
        }

        if (message != null) {
            model.addAttribute("message", message);
        }

        model.addAttribute("manufacturers", manufacturers);
        model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
        model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
        return "vendor/manufacturer/manufacturers-list"; // Tên view để render danh sách nhà sản xuất
    }

    @GetMapping("/manufacturer/{id}")
    public String getManufacturerById(Model model, @PathVariable("id") String id) {
        Optional<Manufacturer> manufacturer = manufacturerService.findById(id);

        if (!manufacturer.isPresent()) {
            String message = "Nhà sản xuất không tồn tại";
            model.addAttribute("error", message);
            return "redirect:/vendor/manufacturers";
        }
        model.addAttribute("manufacturer", manufacturer.get());
        return "vendor/manufacturer/manufacturer-detail";
    }

    @PostMapping("/manufacturer/save")
    public ModelAndView handleModifyForm(ModelMap model,
                                         @Valid @ModelAttribute("manufacturer") ManufacturerModel manufacturerModel,
                                         BindingResult result
                                 ) {
        String message = "";
        Manufacturer manufacturer = new Manufacturer();
        if (result.hasErrors()) {
            message = "Vui lòng sửa các lỗi sau đây và thử lại";
            model.addAttribute("error", message);
            return new ModelAndView("vendor/manufacturer-addOrEdit");
        }
        System.out.println(manufacturerModel);
        BeanUtils.copyProperties(manufacturerModel, manufacturer);
        System.out.println(manufacturer);

        if (manufacturerModel.getIsEdit()) {
            boolean checkEdit = manufacturerService.checkEdit(manufacturer.getId());
            if (checkEdit) {
                model.addAttribute("error", "Không thể sửa nhà sản xuất này");
                return new ModelAndView("vendor/manufacturer/manufacturer-addOrEdit", model);
            }
            manufacturerService.save(manufacturer);
            message = "Nhà sản xuất đã được cập nhật";
        } else {
            Manufacturer lastManufacturer = manufacturerService.findTopByOrderByIdDesc();
            String previousManufacturerId = (lastManufacturer != null) ? lastManufacturer.getId() : "MAN0000";
            manufacturer.setId(manufacturerService.generateManufacturerId(previousManufacturerId));
            manufacturerService.save(manufacturer);
            message = "Nhà sản xuất đã được thêm";
        }
        model.addAttribute("message", message);
        return new ModelAndView("redirect:/vendor/manufacturers", model);
    }

    @GetMapping("/manufacturer/add")
    public String getCreateManufacturerPage(Model model) {
        ManufacturerModel manufacturerModel = new ManufacturerModel();
        manufacturerModel.setIsEdit(false);
        model.addAttribute("manufacturer", manufacturerModel);
        return "vendor/manufacturer/manufacturer-addOrEdit";
    }

    @GetMapping("/manufacturer/edit/{id}")
    public ModelAndView getEditManufacturerPage(ModelMap model, @PathVariable("id") String id) {
        Optional<Manufacturer> manufacturer = manufacturerService.findById(id);

        boolean checkEdit = manufacturerService.checkEdit(manufacturer.get().getId());
        System.out.println(checkEdit);
        if (checkEdit) {
            model.addAttribute("error", "Không thể sửa nhà sản xuất này");
            return new ModelAndView ("redirect:/vendor/manufacturers", model);
        }

        ManufacturerModel manufacturerModel = new ManufacturerModel();
        if (manufacturer.isPresent()) {
            Manufacturer manufacturerEntity = manufacturer.get();
            BeanUtils.copyProperties(manufacturerEntity, manufacturerModel);
            manufacturerModel.setIsEdit(true);
            model.addAttribute("manufacturer", manufacturerModel);
            return new ModelAndView("vendor/manufacturer/manufacturer-addOrEdit", model);
        }
        model.addAttribute("error", "Nhà sản xuất không tồn tại");
        return new ModelAndView("redirect:/vendor/manufacturers", model);
    }

    @GetMapping("/manufacturer/delete/{id}")
    public ModelAndView deleteManufacturer(ModelMap model, @PathVariable("id") String id) {
        Optional<Manufacturer> manufacturer = manufacturerService.findById(id);
        if (manufacturer.isPresent()) {
            boolean checkEdit = manufacturerService.checkEdit(id);
            if (checkEdit) {
                model.addAttribute("error", "Không thể xóa nhà sản xuất này");
                return new ModelAndView("redirect:/vendor/manufacturers", model);
            }
            manufacturerService.deleteById(id);
            model.addAttribute("message", "Nhà sản xuất đã được xóa");
            return new ModelAndView("redirect:/vendor/manufacturers", model);
        }
        model.addAttribute("error", "Nhà sản xuất không tồn tại");
        return new ModelAndView("redirect:/vendor/manufacturers", model);
    }

    @GetMapping("/manufacturer/search")
    public String searchManufacturer(Model model,
                                     @RequestParam("name") String name,
                                     @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                                     @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize) {
        // Đảm bảo currentPage >= 1
        currentPage = Math.max(currentPage, 1);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
        Page<Manufacturer> manufacturers = manufacturerService.findByNameContaining(name, pageable);

        int totalPages = manufacturers.getTotalPages();
        if (totalPages > 0) {
            // Tạo danh sách số trang
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("manufacturers", manufacturers);
        model.addAttribute("currentPage", currentPage);  // Để view biết trang hiện tại
        model.addAttribute("pageSize", pageSize);        // Để view biết kích thước trang
        return "vendor/manufacturer/manufacturers-list";
    }

    @GetMapping("/manufacturer/exist")
    public String manufacturerIsExist(Model model, @RequestParam("name") String name) {
        Boolean check = manufacturerService.existsByName(name);
        if (check) {
            model.addAttribute("message", "Nhà sản xuất đã tồn tại");
        } else {
            model.addAttribute("error", "Nhà sản xuất không tồn tại");
        }
        return "vendor/manufacturer/manufacturer-list";
    }

}
