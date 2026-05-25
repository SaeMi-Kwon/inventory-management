package com.inventory.service;

import com.inventory.dto.ItemDTO;
import com.inventory.exception.CustomException;
import com.inventory.exception.ErrorCode;
import com.inventory.mapper.ItemMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ItemService {

    private final ItemMapper itemMapper;

    // 품목 등록
    public void register(ItemDTO itemDTO) {

        int count = itemMapper.countByItemCode(itemDTO.getItemCode());

        if (count > 0) {
            throw new CustomException(ErrorCode.DUPLICATE_ITEM_CODE);
        }
        itemMapper.insertItem(itemDTO);

    }

    // 품목 목록 + 검색
    public List<ItemDTO> findItemList(ItemDTO searchDTO) {
        return itemMapper.findItemList(searchDTO);
    }

    // 품목 상세정보
    public ItemDTO findItemById(Long itemId) {
        return itemMapper.findItemById(itemId);
    }

    // 품목 수정
    public void updateItem(ItemDTO itemDTO) {
        itemMapper.updateItem(itemDTO);
    }

}
