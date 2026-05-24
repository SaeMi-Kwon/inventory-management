package com.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String dashboard(Model model) {
        model.addAttribute("contentPage", "/WEB-INF/views/dashboard.jsp");
        return "common/layout";
    }
}
