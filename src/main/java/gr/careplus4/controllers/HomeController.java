package gr.careplus4.controllers;

import gr.careplus4.entities.Event;
import gr.careplus4.entities.User;
import gr.careplus4.models.MedicineForUserModel;
import gr.careplus4.services.impl.EventServiceImpl;
import gr.careplus4.services.impl.MedicineServicesImpl;
import gr.careplus4.services.impl.UserServiceImpl;
import gr.careplus4.services.security.JwtCookies;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static com.fasterxml.jackson.databind.type.LogicalType.Map;

@Controller
public class HomeController {

    @Autowired
    private MedicineServicesImpl medicineServices;

    @Autowired
    private EventServiceImpl eventService;

    @GetMapping(path = {"/", "/home"})
    public String index(Model model, @RequestParam(value = "success", required = false) String success,
                        @RequestParam(value = "error", required = false) String error){

        Date date = new Date(System.currentTimeMillis());
        List<Event> events = eventService.getActiveEvents(date);

        List<MedicineForUserModel> top10Selling = medicineServices.findTop9SellingMedicinesFromUniqueList();

        List<java.util.Map<String, Object>> top10Man = medicineServices.findTop9FavoriteBrandsWithDetails();

        List<java.util.Map<String, Object>> top10Cate = medicineServices.findTop9FavoriteCategoriesWithDetails();

        List<Map<String, Object>> top5Popular = medicineServices.findTop3PopularMedicinesLast7Days();

        if(success != null){
            model.addAttribute("success", success);
        }
        if(error != null){
            model.addAttribute("error", error);
        }

        // Thêm dữ liệu vào model
        model.addAttribute("events", events);
        model.addAttribute("topCategories", top10Cate);
        model.addAttribute("topBrands", top10Man);
        model.addAttribute("topProducts", top5Popular);
        model.addAttribute("topSelling", top10Selling);
        return "guest/home";
    }
}