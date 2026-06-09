package com.inventory.service;

import com.inventory.dto.StockDTO;
import com.inventory.dto.StockEditDTO;
import com.inventory.dto.StockHistoryDTO;
import com.inventory.dto.StockListDTO;
import com.inventory.exception.CustomException;
import com.inventory.exception.ErrorCode;
import com.inventory.mapper.StockHistoryMapper;
import com.inventory.mapper.StockMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StockService {

    private final StockMapper stockMapper;
    private final StockHistoryMapper stockHistoryMapper;

    // 재고 등록
    @Transactional
    public void registerStock(StockDTO stockDTO, Long processUserId){

        // 중복 체크
        if (stockMapper.countByItemAndWarehouse(stockDTO) > 0) {
            throw new CustomException(ErrorCode.DUPLICATE_STOCK);
        }

        // 재고 등록
        stockMapper.insertStock(stockDTO);

        // 재고이력 저장
        StockHistoryDTO history = new StockHistoryDTO();
        history.setItemId(stockDTO.getItemId());
        history.setWarehouseId(stockDTO.getWarehouseId());
        history.setHistoryType("INITIAL");
        history.setInboundId(null);
        history.setOutboundId(null);
        history.setBeforeQuantity(0);
        history.setChangeQuantity(stockDTO.getQuantity());
        history.setAfterQuantity(stockDTO.getQuantity());
        history.setProcessUserId(processUserId);
        history.setRemark("초기재고 등록");

        stockHistoryMapper.insertStockHistory(history);
    }

    // 재고 목록 + 검색
    public List<StockListDTO> findStockList(StockListDTO searchDTO){
        return stockMapper.findStockList(searchDTO);
    }

    // 재고 단건 조회
    public StockEditDTO findStockById(Long stockId){
        return stockMapper.findStockById(stockId);
    }

    // 재고 수정
    @Transactional
    public void updateStock(StockEditDTO stockDTO, Long processUserId){

        StockEditDTO currentStock = stockMapper.findStockById(stockDTO.getStockId());

        int beforeQuantity = currentStock.getQuantity();
        int afterQuantity = stockDTO.getQuantity();
        int changeQuantity = afterQuantity - beforeQuantity;

        StockDTO updateDTO = new StockDTO();
        updateDTO.setStockId(stockDTO.getStockId());
        updateDTO.setQuantity(stockDTO.getQuantity());
        updateDTO.setSafetyStock(stockDTO.getSafetyStock());

        stockMapper.updateStock(updateDTO);

        StockHistoryDTO history = new StockHistoryDTO();
        history.setItemId(currentStock.getItemId());
        history.setWarehouseId(currentStock.getWarehouseId());
        history.setHistoryType("ADJUST");
        history.setBeforeQuantity(beforeQuantity);
        history.setChangeQuantity(changeQuantity);
        history.setAfterQuantity(afterQuantity);
        history.setProcessUserId(processUserId);
        history.setRemark(stockDTO.getAdjustRemark());

        stockHistoryMapper.insertStockHistory(history);
    }

}
