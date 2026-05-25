package com.inventory.mapper;

import com.inventory.dto.ItemDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ItemMapper {

    int countByItemCode(String itemCode);

    int insertItem(ItemDTO itemDTO);

    List<ItemDTO> findItemList(ItemDTO searchDTO);

    ItemDTO findItemById(Long itemId);

    int updateItem(ItemDTO itemDTO);

}
