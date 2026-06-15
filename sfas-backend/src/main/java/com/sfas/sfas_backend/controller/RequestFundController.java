package com.sfas.sfas_backend.controller;

import com.sfas.sfas_backend.dto.request.FundStatusUpdateRequest;
import com.sfas.sfas_backend.dto.request.RequestFundRequest;
import com.sfas.sfas_backend.dto.response.RequestFundResponse;
import com.sfas.sfas_backend.service.RequestFundService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/funds")
@RequiredArgsConstructor
public class RequestFundController {

    private final RequestFundService requestFundService;

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<RequestFundResponse> createFundRequest(@Valid @RequestBody RequestFundRequest request,
                                                                 @AuthenticationPrincipal UserDetails userDetails) {
        RequestFundResponse createdFund = requestFundService.createFundRequest(request, userDetails.getUsername());
        URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
                .buildAndExpand(createdFund.id()).toUri();
        return ResponseEntity.created(location).body(createdFund);
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'FINANCE_OFFICER')")
    public ResponseEntity<List<RequestFundResponse>> getAllFundRequests() {
        return ResponseEntity.ok(requestFundService.getAllFundRequests());
    }

    @PatchMapping("/{id}/status")
    @PreAuthorize("hasRole('FINANCE_OFFICER')")
    public ResponseEntity<RequestFundResponse> updateFundStatus(@PathVariable UUID id,
                                                                @Valid @RequestBody FundStatusUpdateRequest request,
                                                                @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(requestFundService.updateFundStatus(id, request.status(), userDetails.getUsername()));
    }
}
