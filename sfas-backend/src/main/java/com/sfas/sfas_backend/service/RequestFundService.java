package com.sfas.sfas_backend.service;

import com.sfas.sfas_backend.dto.request.RequestFundRequest;
import com.sfas.sfas_backend.dto.response.RequestFundResponse;

import java.util.List;
import java.util.UUID;

public interface RequestFundService {
    RequestFundResponse createFundRequest(RequestFundRequest request, String userEmail);
    List<RequestFundResponse> getAllFundRequests();
    RequestFundResponse updateFundStatus(UUID id, com.sfas.sfas_backend.dto.request.FundStatusUpdateRequest request, String reviewerEmail);
}

