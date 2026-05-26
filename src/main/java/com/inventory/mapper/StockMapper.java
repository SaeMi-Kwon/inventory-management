package com.inventory.mapper;

import com.inventory.dto.StockDTO;
import com.inventory.dto.StockEditDTO;
import com.inventory.dto.StockListDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StockMapper {

    int insertStock(StockDTO stockDTO);

    int countByItemAndWarehouse(StockDTO stockDTO);

    List<StockListDTO> findStockList(StockListDTO searchDTO);

    StockEditDTO findStockById(Long stockId);

    int updateStock(StockDTO stockDTO);

    // 현재 창고에 해당 품목 재고 있는지 조회
    StockDTO findStockByItemAndWarehouse(StockDTO stockDTO);

    // 재고 증가
    int increaseStock(StockDTO stockDTO);

}
