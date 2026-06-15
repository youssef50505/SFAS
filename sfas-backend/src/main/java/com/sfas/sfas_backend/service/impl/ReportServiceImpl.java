package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.domain.entity.Report;
import com.sfas.sfas_backend.domain.entity.User;
import com.sfas.sfas_backend.dto.request.ReportRequest;
import com.sfas.sfas_backend.dto.response.ReportResponse;
import com.sfas.sfas_backend.event.NotificationEvent;
import com.sfas.sfas_backend.mapper.ReportMapper;
import com.sfas.sfas_backend.repository.ReportRepository;
import com.sfas.sfas_backend.repository.UserRepository;
import com.sfas.sfas_backend.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {

    private final ReportRepository reportRepository;
    private final UserRepository userRepository;
    private final ReportMapper reportMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Override
    @Transactional
    public ReportResponse createReport(ReportRequest request, String userEmail) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        Report report = reportMapper.toEntity(request);
        report.setCreatedBy(user);

        Report savedReport = reportRepository.save(report);

        eventPublisher.publishEvent(new NotificationEvent("New Report Generated: " + report.getTitle(), userEmail));

        return reportMapper.toResponse(savedReport);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ReportResponse> getAllReports() {
        return reportRepository.findAll().stream()
                .map(reportMapper::toResponse)
                .toList();
    }
}
