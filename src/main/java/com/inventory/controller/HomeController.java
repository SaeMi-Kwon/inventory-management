package com.inventory.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String dashboard(HttpSession session, Model model) {

        if (session.getAttribute("loginUser") == null){
            return "redirect:/login";
        }

        model.addAttribute("contentPage", "/WEB-INF/views/dashboard.jsp");

        return "common/layout";
    }
}
