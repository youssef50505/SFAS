package com.sfas.sfas_backend.dto.request;

import com.sfas.sfas_backend.domain.enums.FundStatus;
import jakarta.validation.constraints.NotNull;

public record FundStatusUpdateRequest(
        @NotNull(message = "Status is required")
        FundStatus status
) {}
