package com.inventory.controller;

import com.inventory.dto.StockHistoryListDTO;
import com.inventory.service.StockHistoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/stockHistories")
public class StockHistoryController {

    private final StockHistoryService stockHistoryService;

    // 재고이력 목록 조회
    @GetMapping("/list")
    public String list(StockHistoryListDTO searchDTO, Model model){

        model.addAttribute("historyList", stockHistoryService.findStockHistoryList(searchDTO));
        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("contentPage", "/WEB-INF/views/stockHistories/list.jsp");

        return "common/layout";
    }

}
