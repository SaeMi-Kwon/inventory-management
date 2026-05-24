package com.inventory.controller;

import com.inventory.dto.CustomerDTO;
import com.inventory.exception.CustomException;
import com.inventory.service.CustomerService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/customers")
public class CustomerController {

    private final CustomerService customerService;

    //거래처 등록 화면
    @GetMapping("/register")
    public String registerForm(Model model){

        model.addAttribute("contentPage","/WEB-INF/views/customers/register.jsp");

        return "common/layout";
    }

    //거래처 등록 처리
    @PostMapping("/register")
    public String register(CustomerDTO customerDTO,Model model){

        try {
            customerService.registerCustomer(customerDTO);

            return "redirect:/customers/register?success=true";

        } catch (CustomException e) {

            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("customer", customerDTO);
            model.addAttribute("contentPage", "/WEB-INF/views/customers/register.jsp");

            return "common/layout";
        }

    }

    // 거래처 목록 + 검색
    @GetMapping("/list")
    public String customerList(CustomerDTO searchDTO, Model model) {

        model.addAttribute("customerList", customerService.findCustomerList(searchDTO));
        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("contentPage", "/WEB-INF/views/customers/list.jsp");

        return "common/layout";
    }

    // 거래처 상세보기
    @GetMapping("/detail/{customerId}")
    public String customerDetail(@PathVariable("customerId") Long customerId, Model model) {

        model.addAttribute("customer", customerService.findCustomerById(customerId));
        model.addAttribute("contentPage", "/WEB-INF/views/customers/detail.jsp");

        return "common/layout";
    }

    // 거래처 수정 화면
    @GetMapping("/edit/{customerId}")
    public String editForm(@PathVariable("customerId") Long customerId, Model model) {

        model.addAttribute("customer", customerService.findCustomerById(customerId));
        model.addAttribute("contentPage", "/WEB-INF/views/customers/edit.jsp");

        return "common/layout";
    }

    // 거래처 수정 처리
    @PostMapping("/edit/{customerId}")
    public String edit(@PathVariable("customerId") Long customerId, CustomerDTO customerDTO) {

        customerDTO.setCustomerId(customerId);
        customerService.updateCustomer(customerDTO);

        return "redirect:/customers/detail/" + customerId;
    }

}
