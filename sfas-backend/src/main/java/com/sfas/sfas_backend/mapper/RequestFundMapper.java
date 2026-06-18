package com.sfas.sfas_backend.mapper;

import com.sfas.sfas_backend.domain.entity.RequestFund;
import com.sfas.sfas_backend.dto.request.RequestFundRequest;
import com.sfas.sfas_backend.dto.response.RequestFundResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public interface RequestFundMapper {
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    @Mapping(target = "reviewedBy", ignore = true)
    @Mapping(target = "reviewComments", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    RequestFund toEntity(RequestFundRequest request);

    RequestFundResponse toResponse(RequestFund entity);
}
