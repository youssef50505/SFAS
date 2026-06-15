package com.sfas.sfas_backend.dto.request;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record BillRequest(
        @NotBlank(message = "Title is required")
        String title,

        @NotBlank(message = "Vendor is required")
        String vendor,

        @NotNull(message = "Amount is required")
        @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than zero")
        BigDecimal amount,

        @NotNull(message = "Tax is required")
        @DecimalMin(value = "0.0", inclusive = true, message = "Tax must be zero or greater")
        BigDecimal tax,

        @NotNull(message = "Date is required")
        LocalDateTime date,

        String imagePath,
        String description
) {}
