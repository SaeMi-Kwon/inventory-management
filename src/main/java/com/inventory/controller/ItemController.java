package com.inventory.controller;

import com.inventory.dto.ItemDTO;
import com.inventory.exception.CustomException;
import com.inventory.service.ItemService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/items")
public class ItemController {

    private final ItemService itemService;

    // 품목 등록 화면
    @GetMapping("/register")
    private String registerForm(Model model){
        model.addAttribute("contentPage","/WEB-INF/views/items/register.jsp");

        return "common/layout";
    }

    //품목 등록 처리
    @PostMapping("/register")
    public String register(ItemDTO itemDTO, Model model){

        try {
            itemService.register(itemDTO);

            return "redirect:/items/register?success=true";

        }catch (CustomException e) {

            model.addAttribute("errorMessage",e.getMessage());
            model.addAttribute("item",itemDTO);
            model.addAttribute("contentPage","/WEB-INF/views/items/register.jsp");

            return "common/layout";
        }

    }

    // 품목 목록 + 검색
    @GetMapping("/list")
    public String itemList(ItemDTO searchDTO, Model model){

        model.addAttribute("itemList", itemService.findItemList(searchDTO));
        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("contentPage", "/WEB-INF/views/items/list.jsp");

        return "common/layout";
    }

    // 품목 상세보기
    @GetMapping("/detail/{itemId}")
    public String itemDetail(@PathVariable("itemId") Long itemId, Model model){

        model.addAttribute("item", itemService.findItemById(itemId));
        model.addAttribute("contentPage", "/WEB-INF/views/items/detail.jsp");

        return "common/layout";
    }

    // 품목 수정 화면
    @GetMapping("/edit/{itemId}")
    public String editForm(@PathVariable("itemId") Long itemId, Model model){

        model.addAttribute("item", itemService.findItemById(itemId));
        model.addAttribute("contentPage", "/WEB-INF/views/items/edit.jsp");

        return "common/layout";
    }

    // 품목 수정 처리
    @PostMapping("/edit/{itemId}")
    public String edit(@PathVariable("itemId") Long itemId, ItemDTO itemDTO){

        itemDTO.setItemId(itemId);
        itemService.updateItem(itemDTO);

        return "redirect:/items/detail/" + itemId;
    }

}
