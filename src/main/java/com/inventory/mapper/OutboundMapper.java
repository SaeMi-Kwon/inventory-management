package com.inventory.mapper;

import com.inventory.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OutboundMapper {

    int insertOutbound(OutboundDTO outboundDTO);

    int insertOutboundDetail(OutboundDetailDTO outboundDetailDTO);

    List<OutboundListDTO> findOutboundList(OutboundListDTO searchDTO);

    OutboundViewDTO findOutboundById(Long outboundId);

    List<OutboundDetailViewDTO> findOutboundDetailList(Long outboundId);

    int updateOutboundStatusCompleted(Long outboundId);


    int updateOutbound(OutboundDTO outboundDTO);

    int deleteOutboundDetails(Long outboundId);

    // DRAFT 상태 출고 취소
    int updateOutboundStatusCanceled(Long outboundId);

    // COMPLETED 상태 출고 취소
    int updateCompletedOutboundStatusCanceled(Long outboundId);
}
