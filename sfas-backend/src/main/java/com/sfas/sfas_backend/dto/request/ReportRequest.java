package com.sfas.sfas_backend.dto.request;

import com.sfas.sfas_backend.domain.enums.ReportType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;

public record ReportRequest(
        @NotNull(message = "Date is required")
        LocalDateTime date,

        @NotBlank(message = "Title is required")
        String title,

        String description,

        @NotNull(message = "Type of report is required")
        ReportType typeOfReport
) {}
