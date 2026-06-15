package com.sfas.sfas_backend.dto.response;

import com.sfas.sfas_backend.domain.enums.CollectionType;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

public record CollectionResponse(
        UUID id,
        LocalDate date,
        CollectionType type,
        BigDecimal amount,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {}
