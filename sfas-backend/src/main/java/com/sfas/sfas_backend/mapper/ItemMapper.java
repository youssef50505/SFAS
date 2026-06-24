package com.sfas.sfas_backend.mapper;

import com.sfas.sfas_backend.domain.entity.Item;
import com.sfas.sfas_backend.dto.request.ItemRequest;
import com.sfas.sfas_backend.dto.response.ItemResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = {UserMapper.class})
public interface ItemMapper {

    Item toEntity(ItemRequest request);

    ItemResponse toResponse(Item item);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    void updateEntityFromRequest(ItemRequest request, @MappingTarget Item item);
}
