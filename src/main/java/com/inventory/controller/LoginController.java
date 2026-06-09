package com.inventory.controller;

import com.inventory.dto.LoginDTO;
import com.inventory.dto.UserDTO;
import com.inventory.exception.CustomException;
import com.inventory.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class LoginController {
    private final UserService userService;

    @GetMapping("/login")
    public String loginForm(){
        return "login";
    }

    @PostMapping("/login")
    public String login(LoginDTO loginDTO, HttpSession session, Model model){

        try {
            UserDTO loginUser = userService.login(loginDTO);
            session.setAttribute("loginUser", loginUser);

            return "redirect:/";

        } catch (CustomException e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){

        session.invalidate();

        return "redirect:/login";
    }
}
