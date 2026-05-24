package com.inventory.controller;

import com.inventory.dto.WarehouseDTO;
import com.inventory.exception.CustomException;
import com.inventory.service.WarehouseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/warehouses")
public class WarehouseController {
    private final WarehouseService warehouseService;

    // 창고 등록 화면
    @GetMapping("/register")
    public String registerForm(Model model) {

        model.addAttribute("contentPage", "/WEB-INF/views/warehouses/register.jsp");

        return "common/layout";
    }

    // 창고 등록 처리
    @PostMapping("/register")
    public String register(WarehouseDTO warehouseDTO, Model model) {

        try {
            warehouseService.registerWarehouse(warehouseDTO);

            return "redirect:/warehouses/register?success=true";

        } catch (CustomException e) {

            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("warehouse", warehouseDTO);
            model.addAttribute("contentPage", "/WEB-INF/views/warehouses/register.jsp");

            return "common/layout";
        }
    }

    // 창고 목록 + 검색
    @GetMapping("/list")
    public String warehouseList(WarehouseDTO searchDTO, Model model) {

        model.addAttribute("warehouseList", warehouseService.findWarehouseList(searchDTO));
        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("contentPage", "/WEB-INF/views/warehouses/list.jsp");

        return "common/layout";
    }

    // 창고 수정 화면
    @GetMapping("/edit/{warehouseId}")
    public String editForm(@PathVariable("warehouseId") Long warehouseId, Model model) {

        model.addAttribute("warehouse", warehouseService.findWarehouseById(warehouseId));
        model.addAttribute("contentPage", "/WEB-INF/views/warehouses/edit.jsp");

        return "common/layout";
    }

    // 창고 수정 처리
    @PostMapping("/edit/{warehouseId}")
    public String edit(@PathVariable("warehouseId") Long warehouseId, WarehouseDTO warehouseDTO) {

        warehouseDTO.setWarehouseId(warehouseId);
        warehouseService.updateWarehouse(warehouseDTO);

        return "redirect:/warehouses/list";
    }

}
