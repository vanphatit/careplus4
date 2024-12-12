package gr.careplus4.controllers.unit.api;

import gr.careplus4.entities.Unit;
import gr.careplus4.models.Response;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.impl.UnitServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("v1/api/units")
public class UnitAPIController {
    @Autowired
    private UnitServicesImpl unitService;

    @GetMapping
    public ResponseEntity<Response> getUnits() {
        List<Unit> units = unitService.findAll();
        Response Responses = new Response(true, "Lấy danh sách thành công", units);
        return new ResponseEntity<>(Responses, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Response> getUnitById(@PathVariable("id") String id) {
        Optional<Unit> unit = unitService.findById(id);
        if (unit.isPresent()) {
            Response Responses = new Response(true, "Tìm thấy đơn vị", unit.get());
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        } else {
            Response Responses = new Response(false, "Không tìm thấy đơn vị", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/add")
    public ResponseEntity<Response> addUnit(@Validated @RequestParam("unitName") String unitName) {
        Boolean check = unitService.existsByName(unitName);
        if (check) {
            Response Responses = new Response(false, "Đơn vị đã tồn tại", null);
            return new ResponseEntity<>(Responses, HttpStatus.BAD_REQUEST);
        } else {
            Unit unit = new Unit();
            unit.setName(unitName);
            unitService.save(unit);
            Response Responses = new Response(true, "Thêm đơn vị thành công", unit);
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        }
    }

    @PostMapping("/update/{id}")
    public ResponseEntity<Response> updateUnit(@PathVariable("id") String id, @Validated @RequestParam("unitName") String unitName) {
        Optional<Unit> unit = unitService.findById(id);
        if (unit.isPresent()) {
            unit.get().setName(unitName);
            unitService.save(unit.get());
            Response Responses = new Response(true, "Cập nhật đơn vị thành công", unit.get());
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        } else {
            Response Responses = new Response(false, "Không tìm thấy đơn vị", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Response> deleteUnit(@PathVariable("id") String id) {
        Optional<Unit> unit = unitService.findById(id);
        if (unit.isPresent()) {
            unitService.deleteById(id);
            Response Responses = new Response(true, "Xóa đơn vị thành công", null);
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        } else {
            Response Responses = new Response(false, "Không tìm thấy đơn vị", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/search")
    public ResponseEntity<Response> searchUnit(@RequestParam("unitName") String unitName, Pageable pageable) {
        Page<Unit> units = unitService.findByNameContaining(unitName, pageable);
        Response Responses = new Response(true, "Tìm thấy danh sách đơn vị", units);
        return new ResponseEntity<>(Responses, HttpStatus.OK);
    }

    @GetMapping("/exist/{unitName}")
    public ResponseEntity<Response> unitIsExist(@PathVariable("unitName") String unitName) {
        Boolean check = unitService.existsByName(unitName);
        if (check) {
            Response Responses = new Response(true, "Đơn vị đã tồn tại", null);
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        } else {
            Response Responses = new Response(false, "Đơn vị chưa tồn tại", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
    }
}
