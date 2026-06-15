package com.sfas.sfas_backend.domain.entity;

import com.sfas.sfas_backend.domain.enums.CollectionType;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.UuidGenerator;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "collections", indexes = {
    @Index(name = "idx_collection_date", columnList = "date")
})
@EntityListeners(AuditingEntityListener.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Collection {

    @Id
    @GeneratedValue
    @UuidGenerator
    @Nullable
    private UUID id;

    @Column(nullable = false)
    @NonNull
    private LocalDate date;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @NonNull
    private CollectionType type;

    @Column(nullable = false)
    @NonNull
    private BigDecimal amount;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "created_by_id", nullable = false)
    @NonNull
    private User createdBy;

    @CreatedDate
    @Column(updatable = false)
    @Nullable
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Nullable
    private LocalDateTime updatedAt;
}
