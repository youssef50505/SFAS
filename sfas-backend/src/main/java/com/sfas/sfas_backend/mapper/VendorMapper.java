package com.sfas.sfas_backend.mapper;

import com.sfas.sfas_backend.domain.entity.Vendor;
import com.sfas.sfas_backend.dto.request.VendorRequest;
import com.sfas.sfas_backend.dto.response.VendorResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface VendorMapper {

    Vendor toEntity(VendorRequest request);

    VendorResponse toResponse(Vendor entity);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    void updateEntityFromRequest(VendorRequest request, @MappingTarget Vendor entity);
}
