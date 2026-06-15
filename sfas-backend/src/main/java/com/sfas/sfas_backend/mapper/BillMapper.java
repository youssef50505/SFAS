package com.sfas.sfas_backend.mapper;

import com.sfas.sfas_backend.domain.entity.Bill;
import com.sfas.sfas_backend.dto.request.BillRequest;
import com.sfas.sfas_backend.dto.response.BillResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = {UserMapper.class, VendorMapper.class})
public interface BillMapper {
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    @Mapping(target = "reviewedBy", ignore = true)
    @Mapping(target = "vendor", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    Bill toEntity(BillRequest request);

    BillResponse toResponse(Bill entity);
}
