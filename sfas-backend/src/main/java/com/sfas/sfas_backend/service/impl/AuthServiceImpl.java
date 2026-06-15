package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.domain.entity.User;
import com.sfas.sfas_backend.dto.request.AuthLoginRequest;
import com.sfas.sfas_backend.dto.response.AuthResponse;
import com.sfas.sfas_backend.security.JwtUtil;
import com.sfas.sfas_backend.security.SecurityUser;
import com.sfas.sfas_backend.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final AuthenticationManager authenticationManager;
    private final JwtUtil jwtUtil;

    @Override
    public AuthResponse login(AuthLoginRequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.email(), request.password())
        );

        SecurityUser securityUser = (SecurityUser) authentication.getPrincipal();
        User user = securityUser.getUser();
        String token = jwtUtil.generateToken(securityUser);

        return new AuthResponse(
                token,
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.getRole()
        );
    }
}
