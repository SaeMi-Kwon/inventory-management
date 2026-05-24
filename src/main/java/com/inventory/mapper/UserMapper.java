package com.inventory.mapper;

import com.inventory.dto.CustomerDTO;
import com.inventory.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {

    List<CustomerDTO> findAuthorityList();

    int countByEmployeeId(String employeeId);

    int insertUser(UserDTO userDTO);

    List<UserDTO> findUserList(UserDTO searchDTO);

    UserDTO findUserById(Long userId);

    int updateUser(UserDTO userDTO);

    int resetPassword(UserDTO userDTO);

}
