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

    // 입고완료 메서드
    @Transactional
    public void completeInbound(Long inboundId, Long processUserId) {

        InboundViewDTO inbound = inboundMapper.findInboundById(inboundId);

        if (inbound == null) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_DETAIL);
        }

        if (!"DRAFT".equals(inbound.getStatus())) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_COMPLETE_STATUS);
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

    // 임시저장(DRAFT) 입고 수정처리
    @Transactional
    public void updateInbound(InboundDTO inboundDTO) {

        InboundViewDTO inbound = inboundMapper.findInboundById(inboundDTO.getInboundId());

        // 입고 데이터가 없는지 확인
        if (inbound == null) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_DETAIL);
        }

        // 입고 상태가 DRAFT인지 확인
        if (!"DRAFT".equals(inbound.getStatus())) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_STATUS);
        }

        // 입고상세가 없는지 확인
        if (inboundDTO.getDetailList() == null || inboundDTO.getDetailList().isEmpty()) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_DETAIL);
        }
        // 입고 수정
        inboundMapper.updateInbound(inboundDTO);
        // 입고상세 전부 삭제
        inboundMapper.deleteInboundDetails(inboundDTO.getInboundId());

        // 새로 입력된 입고상세를 하나씩 반복
        for (InboundDetailDTO detail : inboundDTO.getDetailList()) {

            if (detail.getItemId() == null) {
                throw new CustomException(ErrorCode.INVALID_INBOUND_DETAIL);
            }

            if (detail.getQuantity() == null || detail.getQuantity() <= 0) {
                throw new CustomException(ErrorCode.INVALID_INBOUND_QUANTITY);
            }

            if (detail.getUnitPrice() == null) {
                detail.setUnitPrice(BigDecimal.ZERO);
            }

            if (detail.getUnitPrice().compareTo(BigDecimal.ZERO) < 0) {
                throw new CustomException(ErrorCode.INVALID_INBOUND_PRICE);
            }

            BigDecimal totalPrice =
                    detail.getUnitPrice().multiply(BigDecimal.valueOf(detail.getQuantity()));

            detail.setInboundId(inboundDTO.getInboundId());
            detail.setTotalPrice(totalPrice);

            inboundMapper.insertInboundDetail(detail);
        }
    }

    // 임시저장(DRAFT) 입고 취소처리
    @Transactional
    public void cancelDraftInbound(Long inboundId) {

        // 단건 입고 정보 조회
        InboundViewDTO inbound = inboundMapper.findInboundById(inboundId);

        // 입고가 존재하는지 확인
        if (inbound == null) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_DETAIL);
        }

        // DRAFT 상태인지 확인
        if (!"DRAFT".equals(inbound.getStatus())) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_CANCEL_STATUS);
        }

        inboundMapper.updateInboundStatusCanceled(inboundId);
    }

    // 완료(COMPLETED) 입고 취소처리
    @Transactional
    public void cancelCompletedInbound(Long inboundId, Long processUserId) {

        // 단건 입고 정보 조회
        InboundViewDTO inbound = inboundMapper.findInboundById(inboundId);

        // 입고가 존재하는지 확인
        if (inbound == null) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_DETAIL);
        }

        // COMPLETED 상태인지 확인
        if (!"COMPLETED".equals(inbound.getStatus())) {
            throw new CustomException(ErrorCode.INVALID_INBOUND_CANCEL_STATUS);
        }

        // 입고상세 품목 목록을 조회
        List<InboundDetailViewDTO> detailList = inboundMapper.findInboundDetailList(inboundId);

        // 입고상세 품목을 하나씩 반복
        for (InboundDetailViewDTO detail : detailList) {

            StockDTO searchStock = new StockDTO();
            searchStock.setItemId(detail.getItemId());
            searchStock.setWarehouseId(inbound.getWarehouseId());

            // 품목+창고의 현재고를 조회
            StockDTO currentStock = stockMapper.findStockByItemAndWarehouse(searchStock);

            // 현재고가 없거나, 입고취소할 수량보다 현재고가 적은지 확인
            if (currentStock == null || currentStock.getQuantity() < detail.getQuantity()) {
                throw new CustomException(ErrorCode.NOT_ENOUGH_STOCK);
            }

            int beforeQuantity = currentStock.getQuantity();
            int changeQuantity = detail.getQuantity();
            int afterQuantity = beforeQuantity - changeQuantity;

            StockDTO updateStock = new StockDTO();
            updateStock.setItemId(detail.getItemId());
            updateStock.setWarehouseId(inbound.getWarehouseId());
            updateStock.setQuantity(changeQuantity);

            stockMapper.decreaseStock(updateStock);

            StockHistoryDTO history = new StockHistoryDTO();
            history.setItemId(detail.getItemId());
            history.setWarehouseId(inbound.getWarehouseId());
            history.setHistoryType("INBOUND_CANCEL");
            history.setInboundId(inboundId);
            history.setOutboundId(null);
            history.setBeforeQuantity(beforeQuantity);
            history.setChangeQuantity(-changeQuantity);  //음수저장
            history.setAfterQuantity(afterQuantity);
            history.setProcessUserId(processUserId);
            history.setRemark("입고 취소");

            stockHistoryMapper.insertStockHistory(history);
        }

        inboundMapper.updateCompletedInboundStatusCanceled(inboundId);
    }

}
