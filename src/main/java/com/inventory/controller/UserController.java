package com.inventory.controller;

import com.inventory.dto.PasswordResetDTO;
import com.inventory.dto.UserDTO;
import com.inventory.exception.CustomException;
import com.inventory.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    //사용자 등록 화면
    @GetMapping("/register")
    public String registerForm(Model model){

        model.addAttribute("authorityList", userService.findAuthorityList());
        model.addAttribute("contentPage", "/WEB-INF/views/users/register.jsp");

        return "common/layout";
    }

    //사용자 등록 처리
    @PostMapping("/register")
    public String register(UserDTO userDTO, Model model){

        try {
            userService.registerUser(userDTO);

            // redirect - 등록 후 새로고침했을 때 같은 데이터가 다시 등록되는 걸 막기 위해
            return "redirect:/users/register?success=true";

        }catch (CustomException e) {
            model.addAttribute("errorMessage",e.getMessage());
            model.addAttribute("authorityList", userService.findAuthorityList());
            model.addAttribute("contentPage", "/WEB-INF/views/users/register.jsp");

            return "common/layout";
        }

    }

    // 사용자 목록 + 검색
    @GetMapping("/list")
    public String userList(UserDTO searchDTO, Model model) {

        model.addAttribute("userList", userService.findUserList(searchDTO));
        model.addAttribute("authorityList", userService.findAuthorityList());
        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("contentPage", "/WEB-INF/views/users/list.jsp");

        return "common/layout";
    }

    // 사용자 상세보기
    @GetMapping("/detail/{userId}")
    public String userDetail(@PathVariable("userId") Long userId, Model model) {

        model.addAttribute("user", userService.findUserById(userId));
        model.addAttribute("contentPage", "/WEB-INF/views/users/detail.jsp");

        return "common/layout";
    }


    // 사용자 수정 화면
    @GetMapping("/edit/{userId}")
    public String editForm(@PathVariable("userId") Long userId, Model model) {

        model.addAttribute("user", userService.findUserById(userId));
        model.addAttribute("authorityList", userService.findAuthorityList());
        model.addAttribute("contentPage", "/WEB-INF/views/users/edit.jsp");

        return "common/layout";
    }


    // 사용자 수정 처리
    @PostMapping("/edit/{userId}")
    public String edit(@PathVariable("userId") Long userId, UserDTO userDTO) {

        userDTO.setUserId(userId);
        userService.updateUser(userDTO);

        return "redirect:/users/detail/" + userId;
    }

    // 비밀번호 초기화
    @PostMapping("/resetPassword/{userId}")
    public String resetPassword(@PathVariable("userId") Long userId) {

        userService.resetPassword(userId);

        return "redirect:/users/detail/" + userId;
    }


    // 비밀번호 재설정 화면
    @GetMapping("/password/reset")
    public String passwordResetForm(Model model) {

        model.addAttribute("passwordResetDTO", new PasswordResetDTO());
        model.addAttribute("contentPage", "/WEB-INF/views/users/passwordReset.jsp");

        return "users/passwordReset";
    }

    // 비밀번호 재설정 처리
    @PostMapping("/password/reset")
    public String resetUserPassword(PasswordResetDTO passwordResetDTO, Model model) {

        try {
            userService.resetByUserPassword(passwordResetDTO);

            return "redirect:/login?reset=true";

        } catch (CustomException e) {

            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("passwordResetDTO", passwordResetDTO);

            return "users/passwordReset";
        }
    }

}
