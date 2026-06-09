package com.inventory.service;

import com.inventory.dto.WarehouseDTO;
import com.inventory.exception.CustomException;
import com.inventory.exception.ErrorCode;
import com.inventory.mapper.WarehouseMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WarehouseService {

    private final WarehouseMapper warehouseMapper;

    // 창고 등록
    public void registerWarehouse(WarehouseDTO warehouseDTO){

        int count = warehouseMapper.countByWarehouseCode(warehouseDTO.getWarehouseCode());

        if (count > 0) {
            throw new CustomException(ErrorCode.DUPLICATE_WAREHOUSE_CODE);
        }

        warehouseMapper.insertWarehouse(warehouseDTO);
    }

    // 창고 목록 + 검색
    public List<WarehouseDTO> findWarehouseList(WarehouseDTO searchDTO){
        return warehouseMapper.findWarehouseList(searchDTO);
    }

    // 창고 단건 조회
    public WarehouseDTO findWarehouseById(Long warehouseId){
        return warehouseMapper.findWarehouseById(warehouseId);
    }

    // 창고 수정
    public void updateWarehouse(WarehouseDTO warehouseDTO){
        warehouseMapper.updateWarehouse(warehouseDTO);
    }

}
