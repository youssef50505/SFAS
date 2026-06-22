package com.sfas.sfas_backend.dto.response;

import java.math.BigDecimal;

public record CollectionMetricsResponse(
        BigDecimal today,
        BigDecimal weekly,
        BigDecimal monthly,
        BigDecimal annually
) {}
