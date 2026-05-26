package com.inventory.service;

import com.inventory.dto.*;
import com.inventory.exception.CustomException;
import com.inventory.exception.ErrorCode;
import com.inventory.mapper.InboundMapper;
import com.inventory.mapper.StockHistoryMapper;
import com.inventory.mapper.StockMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class InboundService {

    private final InboundMapper inboundMapper;
    private final StockMapper stockMapper;
    private final StockHistoryMapper stockHistoryMapper;

    // 입고 등록
    @Transactional
    public void registerInbound(InboundDTO inboundDTO){

        if (inboundDTO.getDetailList() == null || inboundDTO.getDetailList().isEmpty()) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_DETAIL);
        }

        // 입고 저장
        inboundMapper.insertInbound(inboundDTO);

        // 방금 저장된 입고 ID 꺼내기
        Long inboundId = inboundDTO.getInboundId();

        if (inboundId == null) {
            throw new CustomException(ErrorCode.INBOUND_ID_NOT_GENERATED);
        }

        // 입고 상세 여러 건 저장
        for (InboundDetailDTO detail : inboundDTO.getDetailList()){

            if (detail.getItemId() == null) {
                throw new CustomException(ErrorCode.INVALID_INBOUND_DETAIL);
            }

            if (detail.getQuantity() == null || detail.getQuantity() <= 0){
                throw new CustomException(ErrorCode.INVALID_INBOUND_QUANTITY);
            }

            if (detail.getUnitPrice() == null){
                detail.setUnitPrice(BigDecimal.ZERO);
            }

            if (detail.getUnitPrice().compareTo(BigDecimal.ZERO) < 0){
                throw new CustomException(ErrorCode.INVALID_INBOUND_PRICE);
            }

            BigDecimal totalPrice =
                    detail.getUnitPrice().multiply(BigDecimal.valueOf(detail.getQuantity()));

            detail.setInboundId(inboundId);
            detail.setTotalPrice(totalPrice);

            inboundMapper.insertInboundDetail(detail);
        }

    }


    // 입고 목록 조회
    public List<InboundListDTO> findInboundList(InboundListDTO searchDTO) {
        return inboundMapper.findInboundList(searchDTO);
    }


    // 입고 상세 조회
    public InboundViewDTO findInboundById(Long inboundId) {

        InboundViewDTO inbound = inboundMapper.findInboundById(inboundId);
        List<InboundDetailViewDTO> detailList = inboundMapper.findInboundDetailList(inboundId);

        inbound.setDetailList(detailList);

        return inbound;
    }

    // 압고완료 메서드
    @Transactional
    public void completeInbound(Long inboundId, Long processUserId) {

        InboundViewDTO inbound = inboundMapper.findInboundById(inboundId);

        if (inbound == null) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_DETAIL);
        }

        if (!"DRAFT".equals(inbound.getStatus())) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_STATUS);
        }

        // 입고상세 품목 목록 조회
        List<InboundDetailViewDTO> detailList = inboundMapper.findInboundDetailList(inboundId);

        for (InboundDetailViewDTO detail : detailList) {

            StockDTO searchStock = new StockDTO();
            searchStock.setItemId(detail.getItemId());
            searchStock.setWarehouseId(inbound.getWarehouseId());

            // 해당 품목이 해당 창고에 이미 재고로 등록되어 있는지 조회
            StockDTO currentStock = stockMapper.findStockByItemAndWarehouse(searchStock);

            int beforeQuantity = 0; //입고 전 재고(초기화)
            int changeQuantity = detail.getQuantity(); //변경 수량
            int afterQuantity;  //입고 후 재고

            // 재고가 아직 없는 경우
            if(currentStock == null){

                afterQuantity = changeQuantity;

                StockDTO newStock = new StockDTO();
                newStock.setItemId(detail.getItemId());
                newStock.setWarehouseId(inbound.getWarehouseId());
                newStock.setQuantity(afterQuantity);
                newStock.setSafetyStock(0);

                stockMapper.insertStock(newStock);

            } else {

                // 입고 전 재고 수량
                beforeQuantity = currentStock.getQuantity();
                afterQuantity = beforeQuantity + changeQuantity;

                StockDTO updateStock = new StockDTO();
                updateStock.setItemId(detail.getItemId());
                updateStock.setWarehouseId(inbound.getWarehouseId());
                updateStock.setQuantity(changeQuantity);  //증가할 수량

                stockMapper.increaseStock(updateStock);  //QUANTITY = QUANTITY + 입고수량
            }

            // 재고이력 저장용
            StockHistoryDTO history = new StockHistoryDTO();
            history.setItemId(detail.getItemId());
            history.setWarehouseId(inbound.getWarehouseId());
            history.setHistoryType("INBOUND");
            history.setInboundId(inboundId);
            history.setOutboundId(null);
            history.setBeforeQuantity(beforeQuantity);
            history.setChangeQuantity(changeQuantity);
            history.setAfterQuantity(afterQuantity);
            history.setProcessUserId(processUserId);
            history.setRemark("입고 완료");

            stockHistoryMapper.insertStockHistory(history);
        }

        // 입고 상태를 COMPLETED로 변경
        inboundMapper.updateInboundStatusCompleted(inboundId);
    }
}
