package gr.careplus4.controllers.vendor;


import gr.careplus4.entities.Event;
import gr.careplus4.models.EventModel;
import gr.careplus4.services.impl.EventServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("vendor/event")
public class EventController {
    @Autowired
    EventServiceImpl eventService;

    @RequestMapping("")
    public String all(Model model) {
        List<Event> list = eventService.findAll();
        model.addAttribute("listevent", list);
        return "vendor/event-list";
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
        EventModel eve = new EventModel();
        model.addAttribute("eve", eve);
        return "vendor/event-add";
    }

    @PostMapping("/save")
    public ModelAndView save(ModelMap model, @Valid @ModelAttribute("eve") EventModel eventModel,
                             BindingResult result) {
        if (result.hasErrors()) {
            System.out.println("Errors: " + result.getAllErrors());
            return new ModelAndView("vendor/event-add");
        }
        Event entity = new Event();
        BeanUtils.copyProperties(eventModel, entity);
        eventService.save(entity);
        String message = "Event added successfully";
        model.addAttribute("message", message);
        return new ModelAndView("redirect:/vendor/event", model);

    }

    @GetMapping("/edit/{id}")
    public ModelAndView edit(ModelMap model, @PathVariable("id") String id) {
        Optional<Event> optionalEvent = eventService.findById(id);
        EventModel eve = new EventModel();
        if (optionalEvent.isPresent()) {
            Event entity = optionalEvent.get();
            BeanUtils.copyProperties(entity, eve);
            model.addAttribute("eve", eve);
            return new ModelAndView("vendor/event-add", model);
        }
        model.addAttribute("mess", "Event not found");
        return new ModelAndView("forward:/vendor/event-list", model);
    }

    @GetMapping("/delete/{id}")
    public String confirmDelete(Model model, @PathVariable("id") String id) {
        Optional<Event> optionalEvent = eventService.findById(id);
        if (optionalEvent.isPresent()) {
            model.addAttribute("event", optionalEvent.get());
            return "vendor/event-delete"; // Hiển thị trang xác nhận xóa
        }
        return "redirect:/vendor/event";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") String id) {
        eventService.deleteById(id); // Phương thức deleteById() do bạn triển khai
        return "redirect:/vendor/event";
    }


}
