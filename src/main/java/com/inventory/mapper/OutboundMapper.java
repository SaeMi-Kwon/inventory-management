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

}
