package com.sfas.sfas_backend.domain.entity;

import com.sfas.sfas_backend.domain.enums.BillStatus;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.UuidGenerator;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "bills", indexes = {
    @Index(name = "idx_bill_status", columnList = "status"),
    @Index(name = "idx_bill_created_by", columnList = "created_by_id")
})
@EntityListeners(AuditingEntityListener.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Bill {

    @Id
    @GeneratedValue
    @UuidGenerator
    @Nullable
    private UUID id;

    @Column(nullable = false)
    @NonNull
    private String title;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vendor_id", nullable = false)
    @NonNull
    private Vendor vendor;

    @Column(nullable = false)
    @NonNull
    private BigDecimal amount;

    @Column(nullable = false)
    @NonNull
    private BigDecimal tax;

    @Column(nullable = false)
    @NonNull
    private LocalDateTime date;

    @Column(name = "image_path")
    @Nullable
    private String imagePath;

    @Column(columnDefinition = "TEXT")
    @Nullable
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @NonNull
    private BillStatus status;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "created_by_id", nullable = false)
    @NonNull
    private User createdBy;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reviewed_by_id")
    @Nullable
    private User reviewedBy;

    @CreatedDate
    @Column(updatable = false)
    @Nullable
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Nullable
    private LocalDateTime updatedAt;
}
