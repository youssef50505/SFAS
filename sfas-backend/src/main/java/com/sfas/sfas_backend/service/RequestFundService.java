package com.sfas.sfas_backend.service;

import com.sfas.sfas_backend.dto.request.RequestFundRequest;
import com.sfas.sfas_backend.dto.response.RequestFundResponse;

import java.util.List;

public interface RequestFundService {
    RequestFundResponse createFundRequest(RequestFundRequest request, String userEmail);
    List<RequestFundResponse> getAllFundRequests();
}
