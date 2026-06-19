import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _Initial;
  const factory DashboardState.loading() = _Loading;
  const factory DashboardState.loaded({
    required double totalFunds,
    required int pendingBillsCount,
    required double monthlyRevenue,
    required int activeVendorsCount,
    required int pendingFundsCount,
    required List<ActivityItem> recentActivities,
  }) = _Loaded;
  const factory DashboardState.error(String message) = _Error;
}

class ActivityItem {
  final String title;
  final String subtitle;
  final DateTime date;
  final IconData icon;
  final Color color;

  ActivityItem({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.icon,
    required this.color,
  });
}
