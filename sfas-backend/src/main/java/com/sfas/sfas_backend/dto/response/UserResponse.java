package com.sfas.sfas_backend.dto.response;

import com.sfas.sfas_backend.domain.enums.Role;

import java.util.UUID;

public record UserResponse(
        UUID id,
        String name,
        String email,
        Role role
) {}
