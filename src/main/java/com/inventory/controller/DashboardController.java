package com.inventory.controller;

import com.inventory.dto.DashboardDTO;
import com.inventory.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class DashboardController {

    private final DashboardService dashboardService;

    @GetMapping("/dashboard")
    public String dashboard(Model model){

        DashboardDTO dashboard = dashboardService.getDashboard();

        model.addAttribute("dashboard", dashboard);
        model.addAttribute("contentPage", "/WEB-INF/views/dashboard/dashboard.jsp");

        return "common/layout";
    }

}
