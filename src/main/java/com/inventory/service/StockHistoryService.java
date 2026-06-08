package com.inventory.service;

import com.inventory.dto.StockHistoryListDTO;
import com.inventory.mapper.StockHistoryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StockHistoryService {

    private final StockHistoryMapper stockHistoryMapper;

    // 재고이력 목록 조회
    public List<StockHistoryListDTO> findStockHistoryList(StockHistoryListDTO searchDTO) {
        return stockHistoryMapper.findStockHistoryList(searchDTO);
    }

}
