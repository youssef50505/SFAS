package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.domain.entity.User;
import com.sfas.sfas_backend.domain.entity.Vendor;
import com.sfas.sfas_backend.dto.request.VendorRequest;
import com.sfas.sfas_backend.dto.response.VendorResponse;
import com.sfas.sfas_backend.exception.ResourceNotFoundException;
import com.sfas.sfas_backend.mapper.VendorMapper;
import com.sfas.sfas_backend.repository.UserRepository;
import com.sfas.sfas_backend.repository.VendorRepository;
import com.sfas.sfas_backend.service.VendorService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class VendorServiceImpl implements VendorService {

    private final VendorRepository vendorRepository;
    private final UserRepository userRepository;
    private final VendorMapper vendorMapper;

    @Override
    @Transactional
    public VendorResponse createVendor(VendorRequest request, String userEmail) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + userEmail));

        Vendor vendor = vendorMapper.toEntity(request);
        vendor.setCreatedBy(user);
        Vendor savedVendor = vendorRepository.save(vendor);
        return vendorMapper.toResponse(savedVendor);
    }

    @Override
    @Transactional(readOnly = true)
    public List<VendorResponse> getAllVendors() {
        return vendorRepository.findAll().stream()
                .map(vendorMapper::toResponse)
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public VendorResponse getVendorById(UUID id) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Vendor not found with id: " + id));
        return vendorMapper.toResponse(vendor);
    }

    @Override
    @Transactional
    public VendorResponse updateVendor(UUID id, VendorRequest request) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Vendor not found with id: " + id));
        
        vendorMapper.updateEntityFromRequest(request, vendor);
        Vendor updatedVendor = vendorRepository.save(vendor);
        return vendorMapper.toResponse(updatedVendor);
    }

    @Override
    @Transactional
    public void deleteVendor(UUID id) {
        if (!vendorRepository.existsById(id)) {
            throw new ResourceNotFoundException("Vendor not found with id: " + id);
        }
        vendorRepository.deleteById(id);
    }
}
