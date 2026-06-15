package com.sfas.sfas_backend.service;

import com.sfas.sfas_backend.dto.request.VendorRequest;
import com.sfas.sfas_backend.dto.response.VendorResponse;

import java.util.List;
import java.util.UUID;

public interface VendorService {
    VendorResponse createVendor(VendorRequest request);
    List<VendorResponse> getAllVendors();
    VendorResponse getVendorById(UUID id);
    VendorResponse updateVendor(UUID id, VendorRequest request);
    void deleteVendor(UUID id);
}
