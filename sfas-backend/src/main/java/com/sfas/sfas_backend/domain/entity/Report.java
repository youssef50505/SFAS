package com.sfas.sfas_backend.domain.entity;

import com.sfas.sfas_backend.domain.enums.ReportType;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.UuidGenerator;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "reports", indexes = {
    @Index(name = "idx_report_created_by", columnList = "created_by_id")
})
@EntityListeners(AuditingEntityListener.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Report {

    @Id
    @GeneratedValue
    @UuidGenerator
    @Nullable
    private UUID id;

    @Column(nullable = false)
    @NonNull
    private LocalDateTime date;

    @Column(nullable = false)
    @NonNull
    private String title;

    @Column(columnDefinition = "TEXT")
    @Nullable
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(name = "type_of_report", nullable = false)
    @NonNull
    private ReportType typeOfReport;

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
