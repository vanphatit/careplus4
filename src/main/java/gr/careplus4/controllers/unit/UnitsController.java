package gr.careplus4.controllers.unit;

import gr.careplus4.entities.Manufacturer;
import gr.careplus4.entities.Unit;
import gr.careplus4.models.UnitModel;
import gr.careplus4.services.impl.UnitServicesImpl;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin")
public class UnitsController {
    @Autowired
    private UnitServicesImpl unitService;

    public UnitsController(UnitServicesImpl unitService) {
        this.unitService = unitService;
    }

    @GetMapping("/units")
    public String getListUnits(Model model,
                               @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                               @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize,
                               @RequestParam(value = "error", required = false) String error,
                                 @RequestParam(value = "message", required = false) String message
    ) {
        // Đảm bảo currentPage >= 1
        currentPage = Math.max(currentPage, 1);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
        Page<Unit> units = unitService.findAll(pageable);

        int totalPages = units.getTotalPages();
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
        model.addAttribute("units", units);
        model.addAttribute("currentPage", currentPage); // Để view biết trang hiện tại
        model.addAttribute("pageSize", pageSize);       // Để view biết kích thước trang
        return "admin/unit/units-list"; // Tên view để render danh sách nhà sản xuất
    }

    @GetMapping("/unit/{id}")
    public String getUnitById(Model model, @PathVariable("id") String id) {
        Optional<Unit> unit = unitService.findById(id);

        if (!unit.isPresent()) {
            return "redirect:/admin/units";
        }
        model.addAttribute("unit", unit.get());
        return "admin/unit/unit-detail";
    }

    @PostMapping("/unit/save")
    public ModelAndView handleModifyForm(ModelMap model,
                                         @Valid @ModelAttribute("unit") UnitModel unitModel,
                                         BindingResult result) {
        String message = "";
        Unit unit = new Unit();

        if (result.hasErrors()) {
            message = "Vui lòng sửa các lỗi sau đây và thử lại";
            model.addAttribute("error", message);
            return new ModelAndView("admin/unit-addOrEdit");
        }
        BeanUtils.copyProperties(unitModel, unit);

        if (unitModel.getIsEdit()) {
            boolean checkUnit = unitService.checkUnit(unit.getId());
            if (checkUnit) {
                model.addAttribute("error", "Đơn vị đang được sử dụng");
                return new ModelAndView("redirect:/admin/units", model);
            }
            unitService.save(unit);
            message = "Đơn vị đã được cập nhật thành công";
            model.addAttribute("message", message);
        } else {
            Unit lastUnit = unitService.findTopByOrderByIdDesc();
            String previousUnitId = (lastUnit != null) ? lastUnit.getId() : "UNT0000";
            unit.setId(unitService.generateUnitId(previousUnitId));
            unitService.save(unit);
            message = "Đơn vị đã được thêm mới thành công";
            model.addAttribute("message", message);
        }
        model.addAttribute("message", message);
        return new ModelAndView("redirect:/admin/unit/units", model);
    }

    @GetMapping("/unit/add")
    public String getCreateUnitPage(Model model) {
        UnitModel unitModel = new UnitModel();
        unitModel.setIsEdit(false);
        model.addAttribute("unit", unitModel);
        return "admin/unit/unit-addOrEdit";
    }

    @GetMapping("/unit/edit/{id}")
    public ModelAndView getEditUnitPage(ModelMap model, @PathVariable("id") String id) {
        Optional<Unit> unit = unitService.findById(id);
        UnitModel unitModel = new UnitModel();

        boolean checkUnit = unitService.checkUnit(id);
        if (checkUnit) {
            model.addAttribute("error", "Đơn vị đang được sử dụng");
            return new ModelAndView("redirect:/admin/units", model);
        }

        if (unit.isPresent()) {
            Unit unitEntity = unit.get();
            BeanUtils.copyProperties(unitEntity, unitModel);
            unitModel.setIsEdit(true);
            model.addAttribute("unit", unitModel);
            return new ModelAndView("admin/unit/unit-addOrEdit", model);
        }
        model.addAttribute("error", "Đơn vị không tồn tại");
        return new ModelAndView("redirect:/admin/unit/units", model);
    }

    @GetMapping("/unit/delete/{id}")
    public ModelAndView deleteUnit(ModelMap model, @PathVariable("id") String id) {
        Optional<Unit> unit = unitService.findById(id);

        if (unit.isPresent()) {

            boolean checkUnit = unitService.checkUnit(id);
            if (checkUnit) {
                model.addAttribute("error", "Đơn vị đang được sử dụng");
                return new ModelAndView("redirect:/admin/units", model);
            }

            unitService.deleteById(id);
            model.addAttribute("error", "Đơn vị đã được xóa thành công");
        } else {
            model.addAttribute("error", "Đơn vị không tồn tại");
        }
        return new ModelAndView("redirect:/admin/unit/units", model);
    }

    @GetMapping("/unit/search")
    public String searchUnit(Model model,
                             @RequestParam("name") String name,
                             @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
                             @RequestParam(value = "size", required = false, defaultValue = "10") int pageSize) {
        currentPage = Math.max(currentPage, 1);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
        Page<Unit> units = unitService.findByNameContaining(name, pageable);

        int totalPages = units.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("units", units);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("pageSize", pageSize);
        return "admin/unit/units-list";
    }

    @GetMapping("/unit/exist")
    public String unitIsExist(Model model, @RequestParam("name") String name) {
        Boolean exists = unitService.existsByName(name);

        if (exists) {
            model.addAttribute("message", "Đơn vị đã tồn tại");
        } else {
            model.addAttribute("error", "Đơn vị không tồn tại");
        }
        return "admin/unit/unit-list";
    }
}
