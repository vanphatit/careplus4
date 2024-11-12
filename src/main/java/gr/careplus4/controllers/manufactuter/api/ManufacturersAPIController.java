package gr.careplus4.controllers.manufactuter.api;

import gr.careplus4.entities.Manufacturer;
import gr.careplus4.models.Response;
import gr.careplus4.services.impl.ManufacturerServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("v1/api/manufacturers")
public class ManufacturersAPIController {
    @Autowired
    private ManufacturerServicesImpl manufacturerService;

    @GetMapping
    public ResponseEntity<Response> getManufacturers() {
        List<Manufacturer> manufacturers = manufacturerService.findAll();
        Response Responses = new Response(true, "Lấy danh sách thành công", manufacturers);
        return new ResponseEntity<>(Responses, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Response> getManufacturerById(@PathVariable("id") String id) {
        Optional<Manufacturer> manufacturer = manufacturerService.findById(id);
        if (manufacturer.isPresent()) {
            Response Responses = new Response(true, "Tìm thấy nhà sản xuất", manufacturer.get());
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        } else {
            Response Responses = new Response(false, "Không tìm thấy nhà sản xuất", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/add")
    public ResponseEntity<Response> addManufacturer(@Validated @RequestParam ("manufactureName") String manufactureName) {
        // Kiem tra xem co ton tai thuoc nao trong database chua
        long count = manufacturerService.count();
        String manufacturerId;
        if (count == 0) {
            manufacturerId = "MAN0001";
        } else {
            Manufacturer lastManufacturer = manufacturerService.findTopByOrderByIdDesc();
            String previousManufacturerId = lastManufacturer.getId();
//            manufacturerId = GenerateID.generateID(previousManufacturerId);
        }

        Boolean check = manufacturerService.existsByName(manufactureName);
        if (check) {
            Response Responses = new Response(false, "Nhà sản xuất đã tồn tại", null);
            return new ResponseEntity<>(Responses, HttpStatus.BAD_REQUEST);
        } else {
            Manufacturer manufacturer = new Manufacturer();
//            manufacturer.setId(manufacturerId);
            manufacturer.setName(manufactureName);
            manufacturerService.save(manufacturer);
            Response Responses = new Response(true, "Thêm nhà sản xuất thành công", manufacturer);
            return new ResponseEntity<>(Responses, HttpStatus.CREATED);
        }
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<Response> updateManufacturer(@PathVariable("id") String id, @Validated @RequestParam("manufactureName") String manufactureName) {
        Optional<Manufacturer> manufacturer = manufacturerService.findById(id);
        if (manufacturer.isPresent()) {
            Manufacturer manufacturerUpdate = manufacturer.get();
            manufacturerUpdate.setName(manufactureName);
            manufacturerService.save(manufacturerUpdate);
            Response Responses = new Response(true, "Cập nhật nhà sản xuất thành công", manufacturerUpdate);
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        } else {
            Response Responses = new Response(false, "Không tìm thấy nhà sản xuất", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Response> deleteManufacturer(@PathVariable("id") String id) {
        Optional<Manufacturer> manufacturer = manufacturerService.findById(id);
        if (manufacturer.isPresent()) {
            manufacturerService.deleteById(id);
            Response Responses = new Response(true, "Xóa nhà sản xuất thành công", null);
            return new ResponseEntity<>(Responses, HttpStatus.OK);
        } else {
            Response Responses = new Response(false, "Không tìm thấy nhà sản xuất", null);
            return new ResponseEntity<>(Responses, HttpStatus.NOT_FOUND);
        }
    }


}
