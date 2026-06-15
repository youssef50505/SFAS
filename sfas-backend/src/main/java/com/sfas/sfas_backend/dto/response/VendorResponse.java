package com.sfas.sfas_backend.dto.response;

import java.time.LocalDateTime;
import java.util.UUID;

public record VendorResponse(
        UUID id,
        String name,
        String contactEmail,
        String phoneNumber,
        String taxId,
        String address,
        UserResponse createdBy,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {}
