package com.sfas.sfas_backend.dto.response;

import com.sfas.sfas_backend.domain.enums.ReportType;

import java.time.LocalDateTime;
import java.util.UUID;

public record ReportResponse(
        UUID id,
        LocalDateTime date,
        String title,
        String description,
        ReportType typeOfReport,
        UserResponse createdBy,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {}
