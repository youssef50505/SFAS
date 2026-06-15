package com.sfas.sfas_backend.service;

import com.sfas.sfas_backend.dto.request.AuthLoginRequest;
import com.sfas.sfas_backend.dto.response.AuthResponse;

public interface AuthService {
    AuthResponse login(AuthLoginRequest request);
}
