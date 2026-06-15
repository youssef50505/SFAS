package com.sfas.sfas_backend.controller;

import com.sfas.sfas_backend.dto.request.VendorRequest;
import com.sfas.sfas_backend.dto.response.VendorResponse;
import com.sfas.sfas_backend.service.VendorService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/vendors")
@RequiredArgsConstructor
public class VendorController {

    private final VendorService vendorService;

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<VendorResponse> createVendor(@Valid @RequestBody VendorRequest request) {
        return new ResponseEntity<>(vendorService.createVendor(request), HttpStatus.CREATED);
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'FINANCE_OFFICER')")
    public ResponseEntity<List<VendorResponse>> getAllVendors() {
        return ResponseEntity.ok(vendorService.getAllVendors());
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'FINANCE_OFFICER')")
    public ResponseEntity<VendorResponse> getVendorById(@PathVariable UUID id) {
        return ResponseEntity.ok(vendorService.getVendorById(id));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<VendorResponse> updateVendor(@PathVariable UUID id, @Valid @RequestBody VendorRequest request) {
        return ResponseEntity.ok(vendorService.updateVendor(id, request));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> deleteVendor(@PathVariable UUID id) {
        vendorService.deleteVendor(id);
        return ResponseEntity.noContent().build();
    }
}
