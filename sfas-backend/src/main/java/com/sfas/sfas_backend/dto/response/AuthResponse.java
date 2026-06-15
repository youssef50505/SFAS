package com.sfas.sfas_backend.dto.response;

import java.util.UUID;
import com.sfas.sfas_backend.domain.enums.Role;

public record AuthResponse(
        String token,
        UUID userId,
        String name,
        String email,
        Role role
) {}
