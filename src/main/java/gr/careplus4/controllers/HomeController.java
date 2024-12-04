package gr.careplus4.controllers;

import gr.careplus4.entities.User;
import gr.careplus4.models.MedicineForUserModel;
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

import java.util.List;
import java.util.Optional;

@Controller
public class HomeController {

    @Autowired
    private MedicineServicesImpl medicineServices;

    @GetMapping(path = {"/", "/home"})
    public String index() {

//        List<MedicineForUserModel> medicineForUserModel = medicineServices.findTop10SellingMedicinesFromUniqueList();
//
//        for (MedicineForUserModel medicine : medicineForUserModel) {
//            System.out.println("=====================================");
//            System.out.println(medicine);
//            System.out.println("=====================================");
//        }

        return "guest/home";
    }
}