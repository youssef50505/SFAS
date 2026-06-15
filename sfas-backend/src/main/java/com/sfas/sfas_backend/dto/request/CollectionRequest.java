package com.sfas.sfas_backend.dto.request;

import com.sfas.sfas_backend.domain.enums.CollectionType;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.time.LocalDate;

public record CollectionRequest(
        @NotNull(message = "Date is required")
        LocalDate date,

        @NotNull(message = "Collection type is required")
        CollectionType type,

        @NotNull(message = "Amount is required")
        @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than zero")
        BigDecimal amount
) {}
