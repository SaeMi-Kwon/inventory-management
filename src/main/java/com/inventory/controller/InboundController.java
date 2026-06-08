package com.inventory.controller;

import com.inventory.dto.*;
import com.inventory.exception.CustomException;
import com.inventory.service.CustomerService;
import com.inventory.service.InboundService;
import com.inventory.service.ItemService;
import com.inventory.service.WarehouseService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/inbounds")
public class InboundController {

    private final InboundService inboundService;
    private final CustomerService customerService;
    private final WarehouseService warehouseService;
    private final ItemService itemService;

    // 입고 등록 화면
    @GetMapping("/register")
    public String registerForm(Model model){

        model.addAttribute("customerList", customerService.findCustomerList(new CustomerDTO()));
        model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
        model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));

        model.addAttribute("contentPage", "/WEB-INF/views/inbounds/register.jsp");

        return "common/layout";
    }

    // 입고 등록 처리
    @PostMapping("register")
    public String register(InboundDTO inboundDTO, HttpSession session,Model model) {

        // 로그인 사용자 조회
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        // 등록자 세팅
        inboundDTO.setCreatedUserId(loginUser.getUserId());

        try {
            // 입고 등록
            inboundService.registerInbound(inboundDTO);

            return "redirect:/inbounds/register?success=true";

        } catch (CustomException e) {

            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("inbound", inboundDTO);
            model.addAttribute("customerList", customerService.findCustomerList(new CustomerDTO()));
            model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
            model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));
            model.addAttribute("contentPage", "/WEB-INF/views/inbounds/register.jsp");

            return "common/layout";
        }
    }

    // 입고 목록
    @GetMapping("/list")
    public String list(InboundListDTO searchDTO, Model model) {

        model.addAttribute("inboundList", inboundService.findInboundList(searchDTO));
        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("contentPage", "/WEB-INF/views/inbounds/list.jsp");

        return "common/layout";
    }

    // 입고 상세
    @GetMapping("/detail/{inboundId}")
    public String detail(@PathVariable("inboundId") Long inboundId, Model model) {

        InboundViewDTO inbound = inboundService.findInboundById(inboundId);
        model.addAttribute("inbound", inbound);
        model.addAttribute("contentPage", "/WEB-INF/views/inbounds/detail.jsp");

        return "common/layout";
    }

    // 입고 완료 처리
    @PostMapping("/complete/{inboundId}")
    public String complete(@PathVariable("inboundId") Long inboundId, HttpSession session) {

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        inboundService.completeInbound(inboundId, loginUser.getUserId());

        return "redirect:/inbounds/detail/" + inboundId;
    }

    // 입고 수정 화면
    @GetMapping("/edit/{inboundId}")
    public String editForm(@PathVariable("inboundId") Long inboundId, Model model) {

        InboundViewDTO inbound = inboundService.findInboundById(inboundId);

        if (!"DRAFT".equals(inbound.getStatus())) {
            return "redirect:/inbounds/detail/" + inboundId;
        }

        model.addAttribute("inbound", inbound);
        model.addAttribute("customerList", customerService.findCustomerList(new CustomerDTO()));
        model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
        model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));
        model.addAttribute("contentPage", "/WEB-INF/views/inbounds/edit.jsp");

        return "common/layout";
    }

    // 입고 수정 처리
    @PostMapping("/edit/{inboundId}")
    public String edit(@PathVariable("inboundId") Long inboundId, InboundDTO inboundDTO, Model model) {

        inboundDTO.setInboundId(inboundId);

        try {
            inboundService.updateInbound(inboundDTO);

            return "redirect:/inbounds/detail/" + inboundId;

        } catch (CustomException e) {

            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("inbound", inboundDTO);
            model.addAttribute("customerList", customerService.findCustomerList(new CustomerDTO()));
            model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
            model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));
            model.addAttribute("contentPage", "/WEB-INF/views/inbounds/edit.jsp");

            return "common/layout";
        }
    }

    // 임시저장(DRAFT) : 입고 취소 처리
    @PostMapping("/cancel/{inboundId}")
    public String cancelDraft(@PathVariable("inboundId") Long inboundId) {

        inboundService.cancelDraftInbound(inboundId);

        return "redirect:/inbounds/detail/" + inboundId;
    }

    // 완료(COMPLETED) : 입고 취소 처리
    @PostMapping("/cancelCompleted/{inboundId}")
    public String cancelCompleted(@PathVariable("inboundId") Long inboundId, HttpSession session) {

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        inboundService.cancelCompletedInbound(inboundId, loginUser.getUserId());

        return "redirect:/inbounds/detail/" + inboundId;
    }

}
