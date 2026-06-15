package com.sfas.sfas_backend.repository;

import com.sfas.sfas_backend.domain.entity.Collection;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface CollectionRepository extends JpaRepository<Collection, UUID> {

    @EntityGraph(attributePaths = {"createdBy"})
    List<Collection> findAll();

    @EntityGraph(attributePaths = {"createdBy"})
    Optional<Collection> findById(UUID id);
}
