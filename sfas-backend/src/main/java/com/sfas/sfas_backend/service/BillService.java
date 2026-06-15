package com.sfas.sfas_backend.service;

import com.sfas.sfas_backend.dto.request.BillRequest;
import com.sfas.sfas_backend.dto.request.BillStatusUpdateRequest;
import com.sfas.sfas_backend.dto.response.BillResponse;

import java.util.List;
import java.util.UUID;

public interface BillService {
    BillResponse createBill(BillRequest request, String userEmail);
    List<BillResponse> getAllBills();
    BillResponse getBillById(UUID id);
    BillResponse updateBillStatus(UUID id, BillStatusUpdateRequest request, String reviewerEmail);
}
