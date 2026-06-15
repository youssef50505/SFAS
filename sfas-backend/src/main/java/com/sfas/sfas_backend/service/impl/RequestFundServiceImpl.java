package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.domain.entity.RequestFund;
import com.sfas.sfas_backend.domain.entity.User;
import com.sfas.sfas_backend.domain.enums.FundStatus;
import com.sfas.sfas_backend.dto.request.RequestFundRequest;
import com.sfas.sfas_backend.dto.response.RequestFundResponse;
import com.sfas.sfas_backend.event.NotificationEvent;
import com.sfas.sfas_backend.exception.ResourceNotFoundException;
import com.sfas.sfas_backend.mapper.RequestFundMapper;
import com.sfas.sfas_backend.repository.RequestFundRepository;
import com.sfas.sfas_backend.repository.UserRepository;
import com.sfas.sfas_backend.service.RequestFundService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RequestFundServiceImpl implements RequestFundService {

    private final RequestFundRepository requestFundRepository;
    private final UserRepository userRepository;
    private final RequestFundMapper requestFundMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Override
    @Transactional
    public RequestFundResponse createFundRequest(RequestFundRequest request, String userEmail) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + userEmail));

        RequestFund fundRequest = requestFundMapper.toEntity(request);
        fundRequest.setCreatedBy(user);

        RequestFund savedFundRequest = requestFundRepository.save(fundRequest);

        eventPublisher.publishEvent(new NotificationEvent("New Fund Request Created: " + fundRequest.getTitle(), userEmail));

        return requestFundMapper.toResponse(savedFundRequest);
    }

    @Override
    @Transactional(readOnly = true)
    public List<RequestFundResponse> getAllFundRequests() {
        return requestFundRepository.findAll().stream()
                .map(requestFundMapper::toResponse)
                .toList();
    }

    @Override
    @Transactional
    public RequestFundResponse updateFundStatus(UUID id, FundStatus status, String reviewerEmail) {
        RequestFund fundRequest = requestFundRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Fund request not found with id: " + id));

        User reviewer = userRepository.findByEmail(reviewerEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + reviewerEmail));

        fundRequest.setStatus(status);
        fundRequest.setReviewedBy(reviewer);
        RequestFund updatedFund = requestFundRepository.save(fundRequest);

        eventPublisher.publishEvent(new NotificationEvent(
                "Fund Request Status Updated to " + status + " for: " + fundRequest.getTitle(),
                fundRequest.getCreatedBy().getEmail()));

        return requestFundMapper.toResponse(updatedFund);
    }
}
