package com.sfas.sfas_backend.repository;

import com.sfas.sfas_backend.domain.entity.Vendor;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface VendorRepository extends JpaRepository<Vendor, UUID> {

    @EntityGraph(attributePaths = {"createdBy"})
    List<Vendor> findAll();

    @EntityGraph(attributePaths = {"createdBy"})
    Optional<Vendor> findById(UUID id);
}
