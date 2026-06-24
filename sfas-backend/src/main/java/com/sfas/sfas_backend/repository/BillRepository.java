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

    @org.springframework.data.jpa.repository.Query("SELECT COALESCE(SUM(b.amount), 0) FROM Bill b WHERE b.createdAt >= :startDate AND b.createdAt < :endDate")
    java.math.BigDecimal sumAmountByDateBetween(@org.springframework.data.repository.query.Param("startDate") java.time.LocalDateTime startDate, @org.springframework.data.repository.query.Param("endDate") java.time.LocalDateTime endDate);
}
