package gr.careplus4.controllers.vendor;


import gr.careplus4.entities.Event;
import gr.careplus4.models.EventModel;
import gr.careplus4.services.impl.EventServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
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
@RequestMapping("vendor/event")
public class EventController {
    @Autowired
    EventServiceImpl eventService;

    @RequestMapping("")
    public String all(Model model, @RequestParam("page") Optional<Integer> page,
                      @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(10);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id")); // Thay đổi nếu cần
        Page<Event> eventPage = eventService.findAll(pageable); // Lấy đối tượng Page<Event>

        model.addAttribute("eventPage", eventPage); // Truyền eventPage vào model
        model.addAttribute("events", eventPage.getContent());

        int totalPages = eventPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
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
        eventService.deleteById(id);
        return "redirect:/vendor/event";
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

        Page<Event> resultPage;
        if (StringUtils.hasText(name)) {
            resultPage = eventService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        } else if (StringUtils.hasText(id)) {
                resultPage = eventService.findById(id, pageable);
                model.addAttribute("id", id);
        }
        else {
            resultPage = eventService.findAll(pageable);
        }

        model.addAttribute("eventPage", resultPage);// Truyền eventPage vào model
        model.addAttribute("events", resultPage.getContent());

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        return "vendor/event-list";
    }

    @GetMapping("/active")
    public String getActiveEvents(@RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date inputDate, Model model) {
        List<Event> activeEvents = eventService.getActiveEvents(inputDate);
        model.addAttribute("inputDate", inputDate);
        model.addAttribute("activeEvents", activeEvents);
        return "vendor/event-active-list"; // Tên file JSP
    }

}
