package com.sfas.sfas_backend.service;

import com.sfas.sfas_backend.dto.request.ReportRequest;
import com.sfas.sfas_backend.dto.response.ReportResponse;

import java.util.List;

public interface ReportService {
    ReportResponse createReport(ReportRequest request, String userEmail);
    List<ReportResponse> getAllReports();
}
