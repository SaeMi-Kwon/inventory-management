package com.inventory.mapper;

import com.inventory.dto.StockHistoryDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StockHistoryMapper {

    int insertStockHistory(StockHistoryDTO stockHistoryDTO);

}
