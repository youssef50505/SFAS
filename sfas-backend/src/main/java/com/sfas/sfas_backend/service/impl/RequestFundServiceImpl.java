package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.domain.entity.RequestFund;
import com.sfas.sfas_backend.domain.entity.User;
import com.sfas.sfas_backend.dto.request.RequestFundRequest;
import com.sfas.sfas_backend.dto.response.RequestFundResponse;
import com.sfas.sfas_backend.event.NotificationEvent;
import com.sfas.sfas_backend.mapper.RequestFundMapper;
import com.sfas.sfas_backend.repository.RequestFundRepository;
import com.sfas.sfas_backend.repository.UserRepository;
import com.sfas.sfas_backend.service.RequestFundService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

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
}
