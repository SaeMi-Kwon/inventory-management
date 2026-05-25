package com.inventory.service;

import com.inventory.dto.StockDTO;
import com.inventory.dto.StockEditDTO;
import com.inventory.dto.StockListDTO;
import com.inventory.exception.CustomException;
import com.inventory.exception.ErrorCode;
import com.inventory.mapper.StockMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StockService {

    private final StockMapper stockMapper;

    // 재고 등록
    public void registerStock(StockDTO stockDTO) {

        // 중복 체크
        if (stockMapper.countByItemAndWarehouse(stockDTO) > 0) {
            throw new CustomException(ErrorCode.DUPLICATE_STOCK);
        }

        stockMapper.insertStock(stockDTO);
    }

    // 재고 목록 + 검색
    public List<StockListDTO> findStockList(StockListDTO searchDTO) {
        return stockMapper.findStockList(searchDTO);
    }

    // 재고 단건 조회
    public StockEditDTO findStockById(Long stockId) {
        return stockMapper.findStockById(stockId);
    }

    // 재고 수정
    public void updateStock(StockDTO stockDTO) {
        stockMapper.updateStock(stockDTO);
    }

}
