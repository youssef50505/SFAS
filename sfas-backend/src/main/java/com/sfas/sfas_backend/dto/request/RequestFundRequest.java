package com.sfas.sfas_backend.dto.request;

import com.sfas.sfas_backend.domain.enums.UrgencyLevel;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record RequestFundRequest(
        @NotBlank(message = "Title is required")
        String title,

        String description,

        @NotNull(message = "Amount of fund is required")
        @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than zero")
        BigDecimal amountOfFund,

        @NotNull(message = "Urgency level is required")
        UrgencyLevel urgencyLevel,

        @NotNull(message = "Date is required")
        LocalDateTime date,

        String imagePath
) {}
