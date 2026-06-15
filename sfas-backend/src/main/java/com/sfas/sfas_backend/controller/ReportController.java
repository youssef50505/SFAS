package com.sfas.sfas_backend.controller;

import com.sfas.sfas_backend.dto.request.ReportRequest;
import com.sfas.sfas_backend.dto.response.ReportResponse;
import com.sfas.sfas_backend.service.ReportService;
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

@RestController
@RequestMapping("/api/v1/reports")
@RequiredArgsConstructor
public class ReportController {

    private final ReportService reportService;

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ReportResponse> createReport(@Valid @RequestBody ReportRequest request,
                                                       @AuthenticationPrincipal UserDetails userDetails) {
        ReportResponse createdReport = reportService.createReport(request, userDetails.getUsername());
        URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
                .buildAndExpand(createdReport.id()).toUri();
        return ResponseEntity.created(location).body(createdReport);
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'FINANCE_OFFICER')")
    public ResponseEntity<List<ReportResponse>> getAllReports() {
        return ResponseEntity.ok(reportService.getAllReports());
    }
}
