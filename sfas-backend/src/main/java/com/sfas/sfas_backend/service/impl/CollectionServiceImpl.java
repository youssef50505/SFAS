package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.dto.response.CollectionMetricsResponse;
import com.sfas.sfas_backend.repository.BillRepository;
import com.sfas.sfas_backend.service.CollectionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.DayOfWeek;

@Service
@RequiredArgsConstructor
public class CollectionServiceImpl implements CollectionService {

    private final BillRepository billRepository;

    @Override
    @Transactional(readOnly = true)
    public CollectionMetricsResponse getCollectionMetrics() {

        // Today: From start of today to start of tomorrow
        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();
        LocalDateTime startOfTomorrow = startOfToday.plusDays(1);
        BigDecimal today = billRepository.sumAmountByDateBetween(startOfToday, startOfTomorrow);

        // Weekly: From start of this week (e.g., Monday) to start of next week
        LocalDateTime startOfWeek = LocalDate.now().with(DayOfWeek.MONDAY).atStartOfDay();
        LocalDateTime startOfNextWeek = startOfWeek.plusWeeks(1);
        BigDecimal weekly = billRepository.sumAmountByDateBetween(startOfWeek, startOfNextWeek);

        // Monthly: From start of this month to start of next month
        LocalDateTime startOfMonth = LocalDate.now().withDayOfMonth(1).atStartOfDay();
        LocalDateTime startOfNextMonth = startOfMonth.plusMonths(1);
        BigDecimal monthly = billRepository.sumAmountByDateBetween(startOfMonth, startOfNextMonth);

        // Annually: From start of this year to start of next year
        LocalDateTime startOfYear = LocalDate.now().withDayOfYear(1).atStartOfDay();
        LocalDateTime startOfNextYear = startOfYear.plusYears(1);
        BigDecimal annually = billRepository.sumAmountByDateBetween(startOfYear, startOfNextYear);

        return new CollectionMetricsResponse(today, weekly, monthly, annually);
    }
}
