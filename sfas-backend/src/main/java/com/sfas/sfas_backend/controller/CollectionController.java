package com.sfas.sfas_backend.controller;

import com.sfas.sfas_backend.dto.response.CollectionMetricsResponse;
import com.sfas.sfas_backend.service.CollectionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/collections")
@RequiredArgsConstructor
public class CollectionController {

    private final CollectionService collectionService;

    @GetMapping("/metrics")
    @PreAuthorize("hasAnyRole('ADMIN', 'FINANCE_OFFICER')")
    public ResponseEntity<CollectionMetricsResponse> getCollectionMetrics() {
        return ResponseEntity.ok(collectionService.getCollectionMetrics());
    }
}
