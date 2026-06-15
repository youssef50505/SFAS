package com.sfas.sfas_backend.service;

import com.sfas.sfas_backend.dto.request.CollectionRequest;
import com.sfas.sfas_backend.dto.response.CollectionResponse;

import java.util.List;

public interface CollectionService {
    CollectionResponse createCollection(CollectionRequest request);
    List<CollectionResponse> getAllCollections();
}
