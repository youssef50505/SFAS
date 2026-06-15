package com.sfas.sfas_backend.mapper;

import com.sfas.sfas_backend.domain.entity.Collection;
import com.sfas.sfas_backend.dto.request.CollectionRequest;
import com.sfas.sfas_backend.dto.response.CollectionResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CollectionMapper {
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    Collection toEntity(CollectionRequest request);

    CollectionResponse toResponse(Collection entity);
}
