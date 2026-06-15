package com.sfas.sfas_backend.repository;

import com.sfas.sfas_backend.domain.entity.Report;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ReportRepository extends JpaRepository<Report, UUID> {

    @EntityGraph(attributePaths = {"createdBy"})
    List<Report> findAll();

    @EntityGraph(attributePaths = {"createdBy"})
    Optional<Report> findById(UUID id);
}
