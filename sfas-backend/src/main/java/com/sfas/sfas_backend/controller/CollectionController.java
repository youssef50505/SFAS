package com.sfas.sfas_backend.controller;

import com.sfas.sfas_backend.dto.request.CollectionRequest;
import com.sfas.sfas_backend.dto.response.CollectionResponse;
import com.sfas.sfas_backend.service.CollectionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/v1/collections")
@RequiredArgsConstructor
public class CollectionController {

    private final CollectionService collectionService;

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<CollectionResponse> createCollection(@Valid @RequestBody CollectionRequest request) {
        CollectionResponse createdCollection = collectionService.createCollection(request);
        URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
                .buildAndExpand(createdCollection.id()).toUri();
        return ResponseEntity.created(location).body(createdCollection);
    }

    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<List<CollectionResponse>> getAllCollections() {
        return ResponseEntity.ok(collectionService.getAllCollections());
    }
}
