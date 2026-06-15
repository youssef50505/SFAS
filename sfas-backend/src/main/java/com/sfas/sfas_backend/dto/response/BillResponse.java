package com.sfas.sfas_backend.dto.response;

import com.sfas.sfas_backend.domain.enums.BillStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

public record BillResponse(
        UUID id,
        String title,
        VendorResponse vendor,
        BigDecimal amount,
        BigDecimal tax,
        LocalDateTime date,
        String imagePath,
        String description,
        BillStatus status,
        UserResponse createdBy,
        UserResponse reviewedBy,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {}
