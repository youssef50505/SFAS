package com.sfas.sfas_backend.repository;

import com.sfas.sfas_backend.domain.entity.Bill;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface BillRepository extends JpaRepository<Bill, UUID> {

    @EntityGraph(attributePaths = {"createdBy", "vendor", "reviewedBy"})
    List<Bill> findAll();

    @EntityGraph(attributePaths = {"createdBy", "vendor", "reviewedBy"})
    Optional<Bill> findById(UUID id);
}
