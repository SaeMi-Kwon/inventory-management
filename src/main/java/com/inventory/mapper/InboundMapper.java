package com.inventory.mapper;

import com.inventory.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface InboundMapper {

    int insertInbound(InboundDTO inboundDTO);

    int insertInboundDetail(InboundDetailDTO detailDTO);

    List<InboundListDTO> findInboundList(InboundListDTO searchDTO);

    InboundViewDTO findInboundById(Long inboundId);

    List<InboundDetailViewDTO> findInboundDetailList(Long inboundId);

    int updateInboundStatusCompleted(Long inboundId);

    int updateInbound(InboundDTO inboundDTO);

    int deleteInboundDetails(Long inboundId);

    int updateInboundStatusCanceled(Long inboundId);

    int updateCompletedInboundStatusCanceled(Long inboundId);

}
