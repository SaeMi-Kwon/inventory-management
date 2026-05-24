package com.inventory.mapper;

import com.inventory.dto.WarehouseDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WarehouseMapper {

    int countByWarehouseCode(String warehouseCode);

    int insertWarehouse(WarehouseDTO warehouseDTO);

    List<WarehouseDTO> findWarehouseList(WarehouseDTO searchDTO);

    WarehouseDTO findWarehouseById(Long warehouseId);

    int updateWarehouse(WarehouseDTO warehouseDTO);

}
