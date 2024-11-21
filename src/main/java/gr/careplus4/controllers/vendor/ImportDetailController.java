package gr.careplus4.controllers.vendor;

import gr.careplus4.entities.Import;
import gr.careplus4.entities.ImportDetail;
import gr.careplus4.entities.Medicine;
import gr.careplus4.models.ImportDetailModel;
import gr.careplus4.services.impl.ImportDetailServiceImpl;
import gr.careplus4.services.impl.ImportServiceImpl;
import gr.careplus4.services.impl.MedicineServicesImpl;
import gr.careplus4.services.impl.ProviderServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Optional;

@Controller
@RequestMapping("vendor/import-detail")
public class ImportDetailController {
    @Autowired
    ImportServiceImpl importService;

    @Autowired
    ImportDetailServiceImpl importDetailService;


    @Autowired
    MedicineServicesImpl medicineService;

    @GetMapping("/add-detail/{importId}")
    public String showAddDetailForm(@PathVariable("importId") String importId, Model model) {
        Optional<Import> importOptional = importService.findById(importId);
        if (importOptional.isPresent()) {
            ImportDetailModel detailModel = new ImportDetailModel();
            detailModel.setMedicineId(""); // Giá trị mặc định
            model.addAttribute("importId", importId);
            model.addAttribute("detail", detailModel);
            return "vendor/import-detail-add"; // JSP Form
        }
        model.addAttribute("error", "Import not found!");
        return "redirect:/vendor/import";
    }

    @PostMapping("/save-detail/{importId}")
    public String saveImportDetail(@PathVariable("importId") String importId,
                                   @Valid @ModelAttribute("detail") ImportDetailModel detailModel,
                                   BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("importId", importId);
            return "vendor/import-detail-add";
        }

        Optional<Import> importOptional = importService.findById(importId);
        if (importOptional.isEmpty()) {
            model.addAttribute("error", "Import not found!");
            return "redirect:/vendor/import";
        }

        // Tìm kiếm Medicine
        Optional<Medicine> medicineOptional = medicineService.findById(detailModel.getMedicineId());
        if (medicineOptional.isEmpty()) {
            model.addAttribute("error", "Medicine not found!");
            return "vendor/import-detail-add";
        }

        // Tạo ImportDetail mới
        Import importEntity = importOptional.get();
        Medicine medicine = medicineOptional.get();

        ImportDetail importDetail = new ImportDetail();
        importDetail.setImportRecord(importEntity);
        importDetail.setMedicine(medicine);
        importDetail.setQuantity(detailModel.getQuantity());
        importDetail.setUnitPrice(detailModel.getUnitPrice());
        importDetailService.save(importDetail);

        return "redirect:/vendor/import";
    }

//    @GetMapping("/edit-detail/{id}")
//    public ModelAndView editImportDetail(ModelMap model, @PathVariable("id") Long id) {
//        // Lấy ImportDetail dựa vào ID
//        Optional<ImportDetail> optionalDetail = importDetailService.findImportDetailById(id);
//
//        if (optionalDetail.isPresent()) {
//            ImportDetail entity = optionalDetail.get();
//            ImportDetailModel detailModel = new ImportDetailModel();
//
//            // Sao chép dữ liệu từ entity sang model
//            BeanUtils.copyProperties(entity, detailModel);
//
//            // Kiểm tra xem Import có tồn tại không
//            Optional<Import> importOptional = importService.findById(entity.getImportRecord().getId());
//            if (importOptional.isEmpty()) {
//                model.addAttribute("error", "Import không tồn tại cho ImportDetail này!");
//                return new ModelAndView("vendor/import/show", model);
//            }
//
//            // Kiểm tra xem Medicine có tồn tại không
//            Optional<Medicine> medicineOptional = medicineService.findById(entity.getMedicine().getId());
//            if (medicineOptional.isEmpty()) {
//                model.addAttribute("error", "Medicine không tồn tại cho ImportDetail này!");
//                return new ModelAndView("vendor/import/show", model);
//            }
//
//            // Truyền dữ liệu vào model để hiển thị ở giao diện chỉnh sửa
//            model.addAttribute("detail", detailModel);
//            model.addAttribute("medicineList", medicineService.findAll()); // Danh sách thuốc
//            return new ModelAndView("vendor/import-detail-edit", model);
//        }
//
//        model.addAttribute("mess", "ImportDetail not found");
//        return new ModelAndView("forward:/vendor/import/show", model);
//    }
//

//    @PostMapping("/edit-detail")
//    public String saveEdit(@Valid @ModelAttribute("detail") ImportDetailModel detailModel, BindingResult result, Model model) {
//        if (result.hasErrors()) {
//            model.addAttribute("medicineList", medicineService.findAll());
//            return "vendor/import-detail-edit";
//        }
//
//        Optional<ImportDetail> optionalDetail = importDetailService.findImportDetailById(detailModel.getImportDetailId());
//        if (optionalDetail.isEmpty()) {
//            model.addAttribute("error", "Import detail not found!");
//            return "redirect:/vendor/import";
//        }
//
//        ImportDetail importDetail = optionalDetail.get();
//        importDetail.setQuantity(detailModel.getQuantity());
//        importDetail.setUnitPrice(detailModel.getUnitPrice());
//        importDetail.setSubTotal(detailModel.getSubTotal());
//
//        importDetailService.save(importDetail); // Lưu thay đổi
//        return "redirect:/vendor/import/show/" + detailModel.getImportId(); // Điều hướng lại danh sách chi tiết
//    }

}
