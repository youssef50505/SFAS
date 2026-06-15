package com.sfas.sfas_backend.mapper;

import com.sfas.sfas_backend.domain.entity.User;
import com.sfas.sfas_backend.dto.response.UserResponse;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserResponse toResponse(User entity);
}
