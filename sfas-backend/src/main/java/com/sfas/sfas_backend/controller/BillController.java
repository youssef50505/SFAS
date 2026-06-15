package com.sfas.sfas_backend.controller;

import com.sfas.sfas_backend.dto.request.BillRequest;
import com.sfas.sfas_backend.dto.request.BillStatusUpdateRequest;
import com.sfas.sfas_backend.dto.response.BillResponse;
import com.sfas.sfas_backend.service.BillService;
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
@RequestMapping("/api/v1/bills")
@RequiredArgsConstructor
public class BillController {

    private final BillService billService;

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<BillResponse> createBill(@Valid @RequestBody BillRequest request,
                                                   @AuthenticationPrincipal UserDetails userDetails) {
        BillResponse createdBill = billService.createBill(request, userDetails.getUsername());
        URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
                .buildAndExpand(createdBill.id()).toUri();
        return ResponseEntity.created(location).body(createdBill);
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'FINANCE_OFFICER')")
    public ResponseEntity<List<BillResponse>> getAllBills() {
        return ResponseEntity.ok(billService.getAllBills());
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'FINANCE_OFFICER')")
    public ResponseEntity<BillResponse> getBillById(@PathVariable UUID id) {
        return ResponseEntity.ok(billService.getBillById(id));
    }

    @PatchMapping("/{id}/status")
    @PreAuthorize("hasRole('FINANCE_OFFICER')")
    public ResponseEntity<BillResponse> updateBillStatus(@PathVariable UUID id,
                                                         @Valid @RequestBody BillStatusUpdateRequest request,
                                                         @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(billService.updateBillStatus(id, request, userDetails.getUsername()));
    }
}
