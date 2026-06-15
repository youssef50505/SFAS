package com.sfas.sfas_backend.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record VendorRequest(
        @NotBlank(message = "Name is required")
        String name,

        @NotBlank(message = "Contact email is required")
        @Email(message = "Invalid email format")
        String contactEmail,

        @NotBlank(message = "Phone number is required")
        String phoneNumber,

        String taxId,
        String address
) {}
