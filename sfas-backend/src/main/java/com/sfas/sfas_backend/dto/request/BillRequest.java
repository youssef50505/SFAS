package com.sfas.sfas_backend.dto.request;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record BillRequest(
        @NotBlank(message = "Title is required")
        String title,

        @NotNull(message = "Vendor ID is required")
        java.util.UUID vendorId,

        @NotNull(message = "Amount is required")
        @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than zero")
        BigDecimal amount,

        @NotNull(message = "Date is required")
        LocalDateTime date,

        String imagePath,
        String description
) {}
