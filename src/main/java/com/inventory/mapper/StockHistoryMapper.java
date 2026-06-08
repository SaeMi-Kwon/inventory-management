package com.inventory.mapper;

import com.inventory.dto.StockHistoryDTO;
import com.inventory.dto.StockHistoryListDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StockHistoryMapper {

    int insertStockHistory(StockHistoryDTO stockHistoryDTO);

    List<StockHistoryListDTO> findStockHistoryList(StockHistoryListDTO searchDTO);

}
