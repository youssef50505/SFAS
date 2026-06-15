package com.sfas.sfas_backend.repository;

import com.sfas.sfas_backend.domain.entity.RequestFund;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface RequestFundRepository extends JpaRepository<RequestFund, UUID> {

    @EntityGraph(attributePaths = {"createdBy"})
    List<RequestFund> findAll();

    @EntityGraph(attributePaths = {"createdBy"})
    Optional<RequestFund> findById(UUID id);
}
