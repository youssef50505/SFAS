package com.sfas.sfas_backend.dto.request;

import com.sfas.sfas_backend.domain.enums.BillStatus;
import jakarta.validation.constraints.NotNull;

public record BillStatusUpdateRequest(
        @NotNull(message = "Status is required")
        BillStatus status,
        
        @org.jspecify.annotations.Nullable
        String comments
) {}
