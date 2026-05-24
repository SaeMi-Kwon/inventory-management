package com.inventory.mapper;

import com.inventory.dto.CustomerDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CustomerMapper {

    int countByCustomerCode(String customerCode);

    int insertCustomer(CustomerDTO customerDTO);

    List<CustomerDTO> findCustomerList(CustomerDTO customerDTO);

    CustomerDTO findCustomerById(Long customerId);

    int updateCustomer(CustomerDTO customerDTO);
}
