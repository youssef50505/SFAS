package com.sfas.sfas_backend.dto.response;

import java.util.UUID;

public record VendorResponse(
        UUID id,
        String name,
        String contactEmail,
        String phoneNumber,
        String taxId,
        String address
) {}
