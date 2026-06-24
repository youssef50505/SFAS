package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.domain.entity.Item;
import com.sfas.sfas_backend.domain.entity.User;
import com.sfas.sfas_backend.dto.request.ItemRequest;
import com.sfas.sfas_backend.dto.response.ItemResponse;
import com.sfas.sfas_backend.exception.ResourceNotFoundException;
import com.sfas.sfas_backend.mapper.ItemMapper;
import com.sfas.sfas_backend.repository.ItemRepository;
import com.sfas.sfas_backend.repository.UserRepository;
import com.sfas.sfas_backend.service.ItemService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ItemServiceImpl implements ItemService {

    private final ItemRepository itemRepository;
    private final UserRepository userRepository;
    private final ItemMapper itemMapper;

    public ItemServiceImpl(ItemRepository itemRepository, UserRepository userRepository, ItemMapper itemMapper) {
        this.itemRepository = itemRepository;
        this.userRepository = userRepository;
        this.itemMapper = itemMapper;
    }

    @Override
    @Transactional
    public ItemResponse createItem(ItemRequest request, String creatorEmail) {
        User creator = userRepository.findByEmail(creatorEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + creatorEmail));

        Item item = itemMapper.toEntity(request);
        item.setCreatedBy(creator);
        
        Item savedItem = itemRepository.save(item);
        return itemMapper.toResponse(savedItem);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ItemResponse> getAllItems() {
        return itemRepository.findAll().stream()
                .map(itemMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public ItemResponse getItemById(UUID id) {
        Item item = itemRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Item not found with ID: " + id));
        return itemMapper.toResponse(item);
    }

    @Override
    @Transactional
    public ItemResponse updateItem(UUID id, ItemRequest request) {
        Item item = itemRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Item not found with ID: " + id));
        
        itemMapper.updateEntityFromRequest(request, item);
        Item updatedItem = itemRepository.save(item);
        
        return itemMapper.toResponse(updatedItem);
    }

    @Override
    @Transactional
    public void deleteItem(UUID id) {
        if (!itemRepository.existsById(id)) {
            throw new ResourceNotFoundException("Item not found with ID: " + id);
        }
        itemRepository.deleteById(id);
    }
}
