package com.inventory.mapper;

import com.inventory.dto.StockDTO;
import com.inventory.dto.StockListDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StockMapper {

    int insertStock(StockDTO stockDTO);

    int countByItemAndWarehouse(StockDTO stockDTO);

    List<StockListDTO> findStockList(StockListDTO searchDTO);

}
