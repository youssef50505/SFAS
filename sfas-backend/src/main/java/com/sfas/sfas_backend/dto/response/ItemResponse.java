package com.sfas.sfas_backend.dto.response;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

public record ItemResponse(
        UUID id,
        String name,
        String description,
        BigDecimal price,
        String category,
        UserResponse createdBy,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}
