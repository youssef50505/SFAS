package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.domain.entity.Collection;
import com.sfas.sfas_backend.domain.entity.User;
import com.sfas.sfas_backend.dto.request.CollectionRequest;
import com.sfas.sfas_backend.dto.response.CollectionResponse;
import com.sfas.sfas_backend.event.NotificationEvent;
import com.sfas.sfas_backend.exception.ResourceNotFoundException;
import com.sfas.sfas_backend.mapper.CollectionMapper;
import com.sfas.sfas_backend.repository.CollectionRepository;
import com.sfas.sfas_backend.repository.UserRepository;
import com.sfas.sfas_backend.service.CollectionService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CollectionServiceImpl implements CollectionService {

    private final CollectionRepository collectionRepository;
    private final UserRepository userRepository;
    private final CollectionMapper collectionMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Override
    @Transactional
    public CollectionResponse createCollection(CollectionRequest request, String userEmail) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + userEmail));

        Collection collection = collectionMapper.toEntity(request);
        collection.setCreatedBy(user);
        Collection savedCollection = collectionRepository.save(collection);

        eventPublisher.publishEvent(new NotificationEvent("New Collection Recorded: " + collection.getType() + " for amount " + collection.getAmount(), userEmail));

        return collectionMapper.toResponse(savedCollection);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CollectionResponse> getAllCollections() {
        return collectionRepository.findAll().stream()
                .map(collectionMapper::toResponse)
                .toList();
    }
}
