package com.inventory.mapper;

import com.inventory.dto.StockHistoryListDTO;
import org.apache.ibatis.annotations.Mapper;

import java.math.BigDecimal;
import java.util.List;

@Mapper
public interface DashboardMapper {

    int countTotalItems();

    int countTotalWarehouses();

    int countLowStocks();

    int countTodayInbounds();

    int countTodayOutbounds();

    List<StockHistoryListDTO> findRecentStockHistories();

}
