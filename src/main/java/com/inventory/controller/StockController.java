package com.inventory.controller;

import com.inventory.dto.*;
import com.inventory.exception.CustomException;
import com.inventory.service.ItemService;
import com.inventory.service.StockService;
import com.inventory.service.WarehouseService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/stocks")
public class StockController {

    private final StockService stockService;
    private final ItemService itemService;
    private final WarehouseService warehouseService;

    // 재고 등록 화면
    @GetMapping("/register")
    public String registerForm(Model model) {

        model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));
        model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
        model.addAttribute("contentPage", "/WEB-INF/views/stocks/register.jsp");

        return "common/layout";
    }

    // 재고 등록 처리
    @PostMapping("/register")
    public String register(StockDTO stockDTO, HttpSession session, Model model) {

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        try {
            stockService.registerStock(stockDTO, loginUser.getUserId());

            return "redirect:/stocks/register?success=true";

        } catch (CustomException e) {

            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("stock", stockDTO);
            model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));
            model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
            model.addAttribute("contentPage", "/WEB-INF/views/stocks/register.jsp");

            return "common/layout";
        }
    }

    // 재고 목록 + 검색
    @GetMapping("/list")
    public String stockList(StockListDTO searchDTO, Model model) {

        model.addAttribute("stockList", stockService.findStockList(searchDTO));
        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("contentPage", "/WEB-INF/views/stocks/list.jsp");

        return "common/layout";
    }

    // 재고 수정 화면
    @GetMapping("/edit/{stockId}")
    public String editForm(@PathVariable("stockId") Long stockId, Model model) {

        model.addAttribute("stock", stockService.findStockById(stockId));
        model.addAttribute("contentPage", "/WEB-INF/views/stocks/edit.jsp");

        return "common/layout";
    }

    // 재고 수정 처리
    @PostMapping("/edit/{stockId}")
    public String edit(@PathVariable("stockId") Long stockId, StockEditDTO stockDTO, HttpSession session) {

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        stockDTO.setStockId(stockId);

        stockService.updateStock(stockDTO, loginUser.getUserId());

        return "redirect:/stocks/list";
    }

}
