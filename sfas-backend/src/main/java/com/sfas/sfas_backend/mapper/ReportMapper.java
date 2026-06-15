package com.sfas.sfas_backend.mapper;

import com.sfas.sfas_backend.domain.entity.Report;
import com.sfas.sfas_backend.dto.request.ReportRequest;
import com.sfas.sfas_backend.dto.response.ReportResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public interface ReportMapper {
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    Report toEntity(ReportRequest request);

    ReportResponse toResponse(Report entity);
}
