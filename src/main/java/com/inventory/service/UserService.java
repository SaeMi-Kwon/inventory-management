package com.inventory.service;


import com.inventory.dto.CustomerDTO;
import com.inventory.dto.LoginDTO;
import com.inventory.dto.UserDTO;
import com.inventory.exception.CustomException;
import com.inventory.exception.ErrorCode;
import com.inventory.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    //권한리스트
    public List<CustomerDTO> findAuthorityList() {
        return userMapper.findAuthorityList();
    }

    //사용자등록
    public void registerUser(UserDTO userDTO) {

        int count = userMapper.countByEmployeeId(userDTO.getEmployeeId());

        if(count > 0) {
            throw new CustomException(ErrorCode.DUPLICATE_EMPLOYEE_ID);
        }

        String encodedPassword = passwordEncoder.encode(userDTO.getPassword());
        userDTO.setPassword(encodedPassword);

        userMapper.insertUser(userDTO);
    }

    //사용자 목록 + 검색
    public List<UserDTO> findUserList(UserDTO searchDTO) {
        return userMapper.findUserList(searchDTO);
    }

    //사용자 상세
    public UserDTO findUserById(Long userId) {
        return userMapper.findUserById(userId);
    }

    //사용자 수정
    public void updateUser(UserDTO userDTO) {
        userMapper.updateUser(userDTO);
    }

    //사용자 비번초기화
    public void resetPassword(Long userId) {
        UserDTO userDTO = new UserDTO();

        userDTO.setUserId(userId);
        userDTO.setPassword(passwordEncoder.encode("0000"));

        userMapper.resetPassword(userDTO);
    }

    // 로그인
    public UserDTO login(LoginDTO loginDTO) {

        UserDTO user = userMapper.findUserByEmployeeId(loginDTO.getEmployeeId());

        if (user == null) {
            throw new CustomException(ErrorCode.LOGIN_FAIL);
        }

        if (!passwordEncoder.matches(loginDTO.getPassword(), user.getPassword())) {
            throw new CustomException(ErrorCode.LOGIN_FAIL);
        }

        if (!"Y".equals(user.getUseYn())) {
            throw new CustomException(ErrorCode.NOT_ACTIVE_USER);
        }

        return user;
    }
}
