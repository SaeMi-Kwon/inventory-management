package com.inventory.controller;

import com.inventory.dto.*;
import com.inventory.exception.CustomException;
import com.inventory.service.CustomerService;
import com.inventory.service.ItemService;
import com.inventory.service.OutboundService;
import com.inventory.service.WarehouseService;
import jakarta.servlet.http.HttpSession;
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
@RequestMapping("/outbounds")
public class OutboundController {

    private final OutboundService outboundService;
    private final CustomerService customerService;
    private final WarehouseService warehouseService;
    private final ItemService itemService;

    // 출고 등록 화면
    @GetMapping("/register")
    public String registerForm(Model model){

        model.addAttribute("customerList", customerService.findCustomerList(new CustomerDTO()));
        model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
        model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));

        model.addAttribute("contentPage", "/WEB-INF/views/outbounds/register.jsp");

        return "common/layout";
    }

    // 출고 등록 처리
    @PostMapping("/register")
    public String register(OutboundDTO outboundDTO, HttpSession session, Model model){

        // 확인용 로그
        System.out.println("detailList = " + outboundDTO.getDetailList());

        if (outboundDTO.getDetailList() != null) {

            for (OutboundDetailDTO detail : outboundDTO.getDetailList()) {

                System.out.println("itemId = " + detail.getItemId());
                System.out.println("quantity = " + detail.getQuantity());
                System.out.println("unitPrice = " + detail.getUnitPrice());
            }
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if(loginUser == null) {
            return "redirect:/login";
        }

        outboundDTO.setCreatedUserId(loginUser.getUserId());

        try {
            outboundService.registerOutbound(outboundDTO);

            return "redirect:/outbounds/register?success=true";

        } catch (CustomException e) {

            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("outbound", outboundDTO);
            model.addAttribute("customerList", customerService.findCustomerList(new CustomerDTO()));
            model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
            model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));
            model.addAttribute("contentPage", "/WEB-INF/views/outbounds/register.jsp");

            return "common/layout";
        }
    }

    // 출고 목록
    @GetMapping("/list")
    public String list(OutboundListDTO searchDTO, Model model){

        model.addAttribute("outboundList", outboundService.findOutboundList(searchDTO));
        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("contentPage", "/WEB-INF/views/outbounds/list.jsp");

        return "common/layout";
    }

    // 출고 상세
    @GetMapping("/detail/{outboundId}")
    public String detail(@PathVariable("outboundId") Long outboundId, Model model){

        model.addAttribute("outbound", outboundService.findOutboundById(outboundId));
        model.addAttribute("contentPage", "/WEB-INF/views/outbounds/detail.jsp");

        return "common/layout";
    }

    // 출고 완료 처리
    @PostMapping("/complete/{outboundId}")
    public String complete(@PathVariable("outboundId") Long outboundId, HttpSession session){

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        outboundService.completeOutbound(outboundId, loginUser.getUserId());

        return "redirect:/outbounds/detail/" + outboundId;
    }

    // 출고 수정 화면
    @GetMapping("/edit/{outboundId}")
    public String editForm(@PathVariable("outboundId") Long outboundId, Model model){

        OutboundViewDTO outbound = outboundService.findOutboundById(outboundId);

        if (!"DRAFT".equals(outbound.getStatus())) {
            return "redirect:/outbounds/detail/" + outboundId;
        }

        model.addAttribute("outbound", outbound);
        model.addAttribute("customerList", customerService.findCustomerList(new CustomerDTO()));
        model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
        model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));
        model.addAttribute("contentPage", "/WEB-INF/views/outbounds/edit.jsp");

        return "common/layout";
    }

    // 출고 수정 처리
    @PostMapping("/edit/{outboundId}")
    public String edit(@PathVariable("outboundId") Long outboundId, OutboundDTO outboundDTO, Model model){

        outboundDTO.setOutboundId(outboundId);

        try {
            outboundService.updateOutbound(outboundDTO);

            return "redirect:/outbounds/detail/" + outboundId;

        } catch (CustomException e) {

            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("outbound", outboundDTO);
            model.addAttribute("customerList", customerService.findCustomerList(new CustomerDTO()));
            model.addAttribute("warehouseList", warehouseService.findWarehouseList(new WarehouseDTO()));
            model.addAttribute("itemList", itemService.findItemList(new ItemDTO()));
            model.addAttribute("contentPage", "/WEB-INF/views/outbounds/edit.jsp");

            return "common/layout";
        }
    }

    // 임시저장(DRAFT) : 출고 취소 처리
    @PostMapping("/cancel/{outboundId}")
    public String cancel(@PathVariable("outboundId") Long outboundId){

        outboundService.cancelDraftOutbound(outboundId);

        return "redirect:/outbounds/detail/" + outboundId;
    }

    // 완료(COMPLETED) : 출고 취소 처리
    @PostMapping("/cancelCompleted/{outboundId}")
    public String cancelCompleted(@PathVariable("outboundId") Long outboundId, HttpSession session){

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        outboundService.cancelCompletedOutbound(outboundId, loginUser.getUserId());

        return "redirect:/outbounds/detail/" + outboundId;
    }
}
