package com.sfas.sfas_backend.domain.entity;

import com.sfas.sfas_backend.domain.enums.FundStatus;
import com.sfas.sfas_backend.domain.enums.UrgencyLevel;
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
@Table(name = "request_funds", indexes = {
    @Index(name = "idx_request_fund_created_by", columnList = "created_by_id")
})
@EntityListeners(AuditingEntityListener.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RequestFund {

    @Id
    @GeneratedValue
    @UuidGenerator
    @Nullable
    private UUID id;

    @Column(nullable = false)
    @NonNull
    private String title;

    @Column(columnDefinition = "TEXT")
    @Nullable
    private String description;

    @Column(name = "amount_of_fund", nullable = false)
    @NonNull
    private BigDecimal amountOfFund;

    @Enumerated(EnumType.STRING)
    @Column(name = "urgency_level", nullable = false)
    @NonNull
    private UrgencyLevel urgencyLevel;

    @Column(nullable = false)
    @NonNull
    private LocalDateTime date;

    @Column(name = "image_path")
    @Nullable
    private String imagePath;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "created_by_id", nullable = false)
    private User createdBy;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @NonNull
    @Builder.Default
    private FundStatus status = FundStatus.PENDING;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reviewed_by_id")
    @Nullable
    private User reviewedBy;

    @Column(columnDefinition = "TEXT")
    @Nullable
    private String reviewComments;

    @CreatedDate
    @Column(updatable = false)
    @Nullable
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Nullable
    private LocalDateTime updatedAt;
}
