package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.domain.entity.Bill;
import com.sfas.sfas_backend.domain.entity.User;
import com.sfas.sfas_backend.domain.enums.BillStatus;
import com.sfas.sfas_backend.dto.request.BillRequest;
import com.sfas.sfas_backend.dto.request.BillStatusUpdateRequest;
import com.sfas.sfas_backend.dto.response.BillResponse;
import com.sfas.sfas_backend.event.NotificationEvent;
import com.sfas.sfas_backend.domain.entity.Vendor;
import com.sfas.sfas_backend.exception.ResourceNotFoundException;
import com.sfas.sfas_backend.mapper.BillMapper;
import com.sfas.sfas_backend.repository.BillRepository;
import com.sfas.sfas_backend.repository.UserRepository;
import com.sfas.sfas_backend.repository.VendorRepository;
import com.sfas.sfas_backend.service.BillService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class BillServiceImpl implements BillService {

    private final BillRepository billRepository;
    private final UserRepository userRepository;
    private final VendorRepository vendorRepository;
    private final BillMapper billMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Override
    @Transactional
    public BillResponse createBill(BillRequest request, String userEmail) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + userEmail));

        Vendor vendor = vendorRepository.findById(request.vendorId())
                .orElseThrow(() -> new ResourceNotFoundException("Vendor not found with id: " + request.vendorId()));

        Bill bill = billMapper.toEntity(request);
        bill.setStatus(BillStatus.PENDING);
        bill.setCreatedBy(user);
        bill.setVendor(vendor);

        Bill savedBill = billRepository.save(bill);

        eventPublisher.publishEvent(new NotificationEvent("New Bill Created: " + bill.getTitle(), userEmail));

        return billMapper.toResponse(savedBill);
    }

    @Override
    @Transactional(readOnly = true)
    public List<BillResponse> getAllBills() {
        return billRepository.findAll().stream()
                .map(billMapper::toResponse)
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public BillResponse getBillById(UUID id) {
        Bill bill = billRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Bill not found with id: " + id));
        return billMapper.toResponse(bill);
    }

    @Override
    @Transactional
    public BillResponse updateBillStatus(UUID id, BillStatusUpdateRequest request, String reviewerEmail) {
        Bill bill = billRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Bill not found with id: " + id));

        User reviewer = userRepository.findByEmail(reviewerEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + reviewerEmail));

        bill.setStatus(request.status());
        bill.setReviewComments(request.comments());
        bill.setReviewedBy(reviewer);
        Bill updatedBill = billRepository.save(bill);

        eventPublisher.publishEvent(new NotificationEvent("Bill Status Updated to " + request.status() + " for: " + bill.getTitle(), bill.getCreatedBy().getEmail()));

        return billMapper.toResponse(updatedBill);
    }
}
