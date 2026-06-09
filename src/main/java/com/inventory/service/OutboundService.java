package com.inventory.service;

import com.inventory.dto.*;
import com.inventory.exception.CustomException;
import com.inventory.exception.ErrorCode;
import com.inventory.mapper.OutboundMapper;
import com.inventory.mapper.StockHistoryMapper;
import com.inventory.mapper.StockMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OutboundService {

    private final OutboundMapper outboundMapper;
    private final StockMapper stockMapper;
    private final StockHistoryMapper stockHistoryMapper;

    // 출고등록
    @Transactional
    public void registerOutbound(OutboundDTO outboundDTO){

        if(outboundDTO.getDetailList() == null || outboundDTO.getDetailList().isEmpty()){
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_DETAIL);
        }

        // 출고 등록
        outboundMapper.insertOutbound(outboundDTO);

        Long outboundId = outboundDTO.getOutboundId();

        // 출고 상세 등록
        for(OutboundDetailDTO detail : outboundDTO.getDetailList()){

            if(detail.getItemId() == null){
                throw new CustomException(ErrorCode.INVALID_OUTBOUND_DETAIL);
            }

            if(detail.getQuantity() == null || detail.getQuantity() <= 0){
                throw new CustomException(ErrorCode.INVALID_OUTBOUND_QUANTITY);
            }

            if(detail.getUnitPrice() == null){
                detail.setUnitPrice(BigDecimal.ZERO);
            }

            if(detail.getUnitPrice().compareTo(BigDecimal.ZERO) < 0){
                throw new CustomException(ErrorCode.INVALID_OUTBOUND_PRICE);
            }

            BigDecimal totalPrice =
                    detail.getUnitPrice().multiply(BigDecimal.valueOf(detail.getQuantity()));

            detail.setOutboundId(outboundId);
            detail.setTotalPrice(totalPrice);

            outboundMapper.insertOutboundDetail(detail);

        }
    }

    // 출고 목록 조회
    public List<OutboundListDTO> findOutboundList(OutboundListDTO searchDTO){
        return outboundMapper.findOutboundList(searchDTO);
    }

    // 출고 상세 조회
    public OutboundViewDTO findOutboundById(Long outboundId){

        OutboundViewDTO outbound = outboundMapper.findOutboundById(outboundId);
        List<OutboundDetailViewDTO> detailList = outboundMapper.findOutboundDetailList(outboundId);

        outbound.setDetailList(detailList);

        return outbound;
    }

    // 출고완료 메서드
    @Transactional
    public void completeOutbound(Long outboundId, Long processUserId){

        // 출고 기본정보 조회
        OutboundViewDTO outbound = outboundMapper.findOutboundById(outboundId);

        // 출고 데이터 없으면 예외
        if (outbound == null) {
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_DETAIL);
        }

        // DRAFT 상태만 출고완료 가능
        if (!"DRAFT".equals(outbound.getStatus())) {
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_COMPLETE_STATUS);
        }

        // 출고상세 목록 조회
        List<OutboundDetailViewDTO> detailList = outboundMapper.findOutboundDetailList(outboundId);

        // 출고상세 반복 처리
        for (OutboundDetailViewDTO detail : detailList) {

            StockDTO searchStock = new StockDTO();
            searchStock.setItemId(detail.getItemId());
            searchStock.setWarehouseId(outbound.getWarehouseId());

            StockDTO currentStock = stockMapper.findStockByItemAndWarehouse(searchStock);

            // 재고 없거나 출고수량보다 부족하면 예외
            if (currentStock == null || currentStock.getQuantity() < detail.getQuantity()) {
                throw new CustomException(ErrorCode.NOT_ENOUGH_STOCK);
            }

            int beforeQuantity = currentStock.getQuantity();
            int changeQuantity = detail.getQuantity();
            int afterQuantity = beforeQuantity - changeQuantity;

            StockDTO updateStock = new StockDTO();
            updateStock.setItemId(detail.getItemId());
            updateStock.setWarehouseId(outbound.getWarehouseId());
            updateStock.setQuantity(changeQuantity);

            stockMapper.decreaseStock(updateStock);

            StockHistoryDTO history = new StockHistoryDTO();
            history.setItemId(detail.getItemId());
            history.setWarehouseId(outbound.getWarehouseId());
            history.setHistoryType("OUTBOUND");
            history.setInboundId(null);
            history.setOutboundId(outboundId);
            history.setBeforeQuantity(beforeQuantity);
            history.setChangeQuantity(-changeQuantity);  //음수로 저장
            history.setAfterQuantity(afterQuantity);
            history.setProcessUserId(processUserId);
            history.setRemark("출고 완료");

            stockHistoryMapper.insertStockHistory(history);
        }

        // 출고 상태 COMPLETED 변경
        outboundMapper.updateOutboundStatusCompleted(outboundId);
    }

    // 임시저장(DRAFT) 출고 수정처리
    @Transactional
    public void updateOutbound(OutboundDTO outboundDTO){

        OutboundViewDTO outbound =
                outboundMapper.findOutboundById(outboundDTO.getOutboundId());

        if (outbound == null) {
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_DETAIL);
        }

        if (!"DRAFT".equals(outbound.getStatus())) {
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_STATUS);
        }

        if (outboundDTO.getDetailList() == null || outboundDTO.getDetailList().isEmpty()) {
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_DETAIL);
        }

        // 출고 수정
        outboundMapper.updateOutbound(outboundDTO);
        // 출고상세 전부 삭제
        outboundMapper.deleteOutboundDetails(outboundDTO.getOutboundId());

        // 새로 입력된 출고상세를 하나씩 반복
        for (OutboundDetailDTO detail : outboundDTO.getDetailList()) {

            if (detail.getItemId() == null) {
                throw new CustomException(ErrorCode.INVALID_OUTBOUND_DETAIL);
            }

            // 수량이 없거나 0 이하인지 확인
            if (detail.getQuantity() == null || detail.getQuantity() <= 0) {
                throw new CustomException(ErrorCode.INVALID_OUTBOUND_QUANTITY);
            }

            // 단가가 비어 있으면 0 처리
            if (detail.getUnitPrice() == null) {
                detail.setUnitPrice(BigDecimal.ZERO);
            }

            // 단가가 음수인지 검사
            if (detail.getUnitPrice().compareTo(BigDecimal.ZERO) < 0) {
                throw new CustomException(ErrorCode.INVALID_OUTBOUND_PRICE);
            }

            // 출고금액을 계산
            BigDecimal totalPrice =
                    detail.getUnitPrice().multiply(BigDecimal.valueOf(detail.getQuantity()));

            detail.setOutboundId(outboundDTO.getOutboundId());
            detail.setTotalPrice(totalPrice);

            outboundMapper.insertOutboundDetail(detail);
        }
    }

    // 임시저장(DRAFT) 출고 취소처리
    @Transactional
    public void cancelDraftOutbound(Long outboundId){

        OutboundViewDTO outbound = outboundMapper.findOutboundById(outboundId);

        if (outbound == null) {
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_DETAIL);
        }

        if (!"DRAFT".equals(outbound.getStatus())) {
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_CANCEL_STATUS);
        }

        outboundMapper.updateOutboundStatusCanceled(outboundId);
    }

    // 완료(COMPLETED) 출고 취소처리
    @Transactional
    public void cancelCompletedOutbound(Long outboundId, Long processUserId){

        // 단건 출고 조회
        OutboundViewDTO outbound = outboundMapper.findOutboundById(outboundId);

        if (outbound == null) {
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_DETAIL);
        }

        // COMPLETED 상태만 출고취소 가능
        if (!"COMPLETED".equals(outbound.getStatus())) {
            throw new CustomException(ErrorCode.INVALID_OUTBOUND_CANCEL_STATUS);
        }

        // 출고상세 품목 목록을 조회
        List<OutboundDetailViewDTO> detailList = outboundMapper.findOutboundDetailList(outboundId);

        for (OutboundDetailViewDTO detail : detailList) {

            StockDTO searchStock = new StockDTO();
            searchStock.setItemId(detail.getItemId());
            searchStock.setWarehouseId(outbound.getWarehouseId());
            // 해당 품목과 창고의 현재고를 조회
            StockDTO currentStock = stockMapper.findStockByItemAndWarehouse(searchStock);

            // 재고 데이터가 없으면 원복할 수 없으므로 예외
            if (currentStock == null) {
                throw new CustomException(ErrorCode.NOT_ENOUGH_STOCK);
            }

            int beforeQuantity = currentStock.getQuantity();
            int changeQuantity = detail.getQuantity();
            int afterQuantity = beforeQuantity + changeQuantity;

            StockDTO updateStock = new StockDTO();
            updateStock.setItemId(detail.getItemId());
            updateStock.setWarehouseId(outbound.getWarehouseId());
            updateStock.setQuantity(changeQuantity);

            //재고를 다시 증가
            stockMapper.increaseStock(updateStock);

            StockHistoryDTO history = new StockHistoryDTO();
            history.setItemId(detail.getItemId());
            history.setWarehouseId(outbound.getWarehouseId());
            history.setHistoryType("OUTBOUND_CANCEL");
            history.setInboundId(null);
            history.setOutboundId(outboundId);
            history.setBeforeQuantity(beforeQuantity);
            history.setChangeQuantity(changeQuantity);
            history.setAfterQuantity(afterQuantity);
            history.setProcessUserId(processUserId);
            history.setRemark("출고 취소");

            stockHistoryMapper.insertStockHistory(history);
        }

        outboundMapper.updateCompletedOutboundStatusCanceled(outboundId);
    }


}
