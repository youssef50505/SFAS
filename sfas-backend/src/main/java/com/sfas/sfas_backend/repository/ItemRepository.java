package com.sfas.sfas_backend.repository;

import com.sfas.sfas_backend.domain.entity.Item;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ItemRepository extends JpaRepository<Item, UUID> {

    @EntityGraph(attributePaths = {"createdBy"})
    List<Item> findAll();

    @EntityGraph(attributePaths = {"createdBy"})
    Optional<Item> findById(UUID id);
}
