package com.sfas.sfas_backend.service;

import com.sfas.sfas_backend.dto.request.ItemRequest;
import com.sfas.sfas_backend.dto.response.ItemResponse;

import java.util.List;
import java.util.UUID;

public interface ItemService {
    ItemResponse createItem(ItemRequest request, String creatorEmail);
    List<ItemResponse> getAllItems();
    ItemResponse getItemById(UUID id);
    ItemResponse updateItem(UUID id, ItemRequest request);
    void deleteItem(UUID id);
}
