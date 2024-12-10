package gr.careplus4.controllers.vendor;

import gr.careplus4.entities.Import;
import gr.careplus4.entities.ImportDetail;
import gr.careplus4.entities.Medicine;
import gr.careplus4.models.ImportDetailModel;
import gr.careplus4.services.impl.*;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.Date;
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
    public String showAddDetailForm(@PathVariable("importId") String importId,
                                    @RequestParam(value = "medicineId", required = false) String medicineId,
                                    ModelMap model) {
        Optional<Import> importOptional = importService.findById(importId);

        if (importOptional.isPresent()) {
            ImportDetailModel detailModel = new ImportDetailModel();
            detailModel.setMedicineId(""); // Giá trị mặc định
            model.addAttribute("importId", importId);
            model.addAttribute("medicineId", medicineId);
            model.addAttribute("detail", detailModel);
            return "vendor/import/import-detail-add"; // JSP Form
        }
        model.addAttribute("error", "Import not found!");
        return "redirect:/vendor/import";
    }

    @PostMapping("/save-detail/{importId}")
    public ModelAndView saveImportDetail(@PathVariable("importId") String importId,
                                         @Valid @ModelAttribute("detail") ImportDetailModel detailModel,
                                         BindingResult result,
                                         ModelMap model) {
        if (result.hasErrors()) {
            System.out.println("Errors: " + result.getAllErrors());
            model.addAttribute("importId", importId);
            return new ModelAndView("vendor/import/import-detail-add", model);
        }

        // Kiểm tra Import tồn tại
        Import importEntity = importService.findById(importId).orElse(null);
        if (importEntity == null) {
            model.addAttribute("error", "Import không tồn tại!");
            return new ModelAndView("vendor/import/import-detail-add", model);
        }

        // Kiểm tra Medicine tồn tại
        Medicine medicine = medicineService.findById(detailModel.getMedicineId()).orElse(null);
        if (medicine == null) {
            model.addAttribute("error", "Medicine không tồn tại!");
            return new ModelAndView("vendor/import/import-detail-add", model);
        }

        // Tạo mới ImportDetail và ánh xạ dữ liệu
        ImportDetail importDetail = new ImportDetail();
        importDetail.setImportRecord(importEntity);
        importDetail.setMedicine(medicine);
        importDetail.setQuantity(detailModel.getQuantity());
        importDetail.setUnitPrice(detailModel.getUnitPrice());
        importDetailService.save(importDetail); // Lưu ImportDetail

        // Cập nhật totalAmount của Import
        importService.updateTotalAmount(importId, importDetail.getSubTotal());

        // Gọi hàm cập nhật giá bán (unitPrice)
        medicineService.updateUnitPriceFollowUniCost(
                medicine.getName(),
                medicine.getManufacturer().getName(),
                medicine.getExpiryDate(),
                new Date(), // Ngày hiện tại
                importDetail.getUnitPrice()
        );

        // Gọi hàm cập nhật số lượng tồn kho
        medicineService.updateStockQuantity(
                medicine.getName(),
                medicine.getManufacturer().getName(),
                medicine.getExpiryDate(),
                new Date(), // Ngày hiện tại
                detailModel.getQuantity()
        );

        model.addAttribute("message", "Import Detail added successfully");
        return new ModelAndView("redirect:/vendor/import", model);
    }

    @GetMapping("/delete-detail/{id}")
    public String deleteImportDetail(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Optional<ImportDetail> importDetailOptional = importDetailService.findById(id);
        if (importDetailOptional.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Import Detail không tồn tại!");
            return "redirect:/vendor/import";
        }

        boolean checkDelete = importDetailService.checkDelete(id);

        try {
            if (checkDelete) {
                ImportDetail importDetail = importDetailOptional.get();

                boolean checkMedicineInBillOrReviewOrCart = importDetailService.checkMedicineInBillOrReviewOrCart(importDetail.getMedicine().getId());

                if (checkMedicineInBillOrReviewOrCart) {
                    redirectAttributes.addFlashAttribute("error", "Không thể xóa Import Detail: Medicine đã được sử dụng trong Bill hoặc Review hoặc Cart!");
                    return "redirect:/vendor/import/show/" + importDetail.getImportRecord().getId();
                }

                importDetailService.deleteById(id); // Xóa ImportDetail
                importService.updateTotalAmount(importDetail.getImportRecord().getId(), importDetail.getSubTotal().negate());
                medicineService.deleteById(importDetail.getMedicine().getId());
                redirectAttributes.addFlashAttribute("message", "Xóa Import Detail thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể xóa Import Detail: Số lượng tồn kho không đủ!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa Import Detail: " + e.getMessage());
        }

        return "redirect:/vendor/import/show/" + importDetailOptional.get().getImportRecord().getId();
    }

    @GetMapping("/edit-detail/{id}")
    public String editImportDetail(@PathVariable("id") Long id, ModelMap model) {
        Optional<ImportDetail> optionalDetail = importDetailService.findImportDetailById(id);

        if (optionalDetail.isPresent()) {
            ImportDetail entity = optionalDetail.get();
            ImportDetailModel detailModel = new ImportDetailModel();

            // Sao chép dữ liệu từ entity sang model
            detailModel.setImportDetailId(entity.getId());
            detailModel.setImportId(entity.getImportRecord().getId());
            detailModel.setMedicineId(entity.getMedicine().getId());
            detailModel.setQuantity(entity.getQuantity());
            detailModel.setUnitPrice(entity.getUnitPrice());
            detailModel.setSubTotal(entity.getSubTotal());


            // Kiểm tra xem Import có tồn tại không
            Optional<Import> importOptional = importService.findById(entity.getImportRecord().getId());
            if (importOptional.isEmpty()) {
                model.addAttribute("error", "Import không tồn tại cho ImportDetail này!");
                return "redirect:/vendor/import";
            }

            // Kiểm tra xem Medicine có tồn tại không
            Optional<Medicine> medicineOptional = medicineService.findById(entity.getMedicine().getId());
            if (medicineOptional.isEmpty()) {
                model.addAttribute("error", "Medicine không tồn tại cho ImportDetail này!");
                return "redirect:/vendor/import/show/" + entity.getImportRecord().getId();
            }

            // Truyền dữ liệu vào model để hiển thị ở giao diện chỉnh sửa
            model.addAttribute("detail", detailModel);
            model.addAttribute("importId", entity.getImportRecord().getId());
            return "vendor/import/import-detail-add"; // Tên JSP được sử dụng cho cả thêm và chỉnh sửa
        }

        model.addAttribute("error", "ImportDetail không tồn tại!");
        return "redirect:/vendor/import/show/" + optionalDetail.get().getImportRecord().getId();
    }

    @PostMapping("/edit-detail/{id}")
    public String updateImportDetail(
            @PathVariable("id") Long id,
            @Valid @ModelAttribute("detail") ImportDetailModel detailModel,
            BindingResult result,
            RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Dữ liệu không hợp lệ!");
            return "redirect:/vendor/import-detail/edit-detail/" + id;
        }

        Optional<ImportDetail> optionalDetail = importDetailService.findImportDetailById(id);
        if (optionalDetail.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Import Detail không tồn tại!");
            return "redirect:/vendor/import/show" + optionalDetail.get().getImportRecord().getId();
        }

        // Kiểm tra số lượng tồn kho
        boolean checkDelete = importDetailService.checkDelete(id);
        if (!checkDelete) {
            redirectAttributes.addFlashAttribute("error", "Không thể chỉnh sửa Import Detail: Số lượng tồn kho không đủ!");
            return "redirect:/vendor/import/show/" + optionalDetail.get().getImportRecord().getId();
        }

        ImportDetail importDetail = optionalDetail.get();
        importDetail.setQuantity(detailModel.getQuantity());
        importDetail.setUnitPrice(detailModel.getUnitPrice());
        BigDecimal quantity = new BigDecimal(detailModel.getQuantity());
        importDetail.setSubTotal(quantity.multiply(detailModel.getUnitPrice()));

        try {
            importDetailService.save(importDetail);

            // Cập nhật lại totalAmount của Import
            importService.updateTotalAmount(importDetail.getImportRecord().getId(),
                    importDetail.getSubTotal().subtract(importDetail.getSubTotal()));

            redirectAttributes.addFlashAttribute("message", "Chỉnh sửa Import Detail thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi chỉnh sửa Import Detail: " + e.getMessage());
        }

        return "redirect:/vendor/import/show/" + importDetail.getImportRecord().getId();
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
