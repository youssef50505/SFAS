package com.sfas.sfas_backend.dto.response;

import com.sfas.sfas_backend.domain.enums.FundStatus;
import com.sfas.sfas_backend.domain.enums.UrgencyLevel;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

public record RequestFundResponse(
        UUID id,
        String title,
        String description,
        BigDecimal amountOfFund,
        UrgencyLevel urgencyLevel,
        LocalDateTime date,
        String imagePath,
        FundStatus status,
        UserResponse createdBy,
        UserResponse reviewedBy,
        String reviewComments,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {}
