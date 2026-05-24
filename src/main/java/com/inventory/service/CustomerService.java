package com.inventory.service;

import com.inventory.dto.CustomerDTO;
import com.inventory.exception.CustomException;
import com.inventory.exception.ErrorCode;
import com.inventory.mapper.CustomerMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CustomerService {

    private final CustomerMapper customerMapper;

    // 거래처 등록
    public void registerCustomer(CustomerDTO customerDTO){
        int count = customerMapper.countByCustomerCode(customerDTO.getCustomerCode());

        if (count > 0) {
            throw new CustomException(ErrorCode.DUPLICATE_CUSTOMER_CODE);
        }

        customerMapper.insertCustomer(customerDTO);
    }

    // 거래처 목록 + 검색
    public List<CustomerDTO> findCustomerList(CustomerDTO searchDTO) {
        return customerMapper.findCustomerList(searchDTO);
    }

    // 거래처 상세보기
    public CustomerDTO findCustomerById(Long customerId){
        return customerMapper.findCustomerById(customerId);
    }

    // 거래처 수정
    public void updateCustomer(CustomerDTO customerDTO) {
        customerMapper.updateCustomer(customerDTO);
    }

}
