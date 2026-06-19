import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports_event.freezed.dart';

@freezed
class ReportsEvent with _$ReportsEvent {
  const factory ReportsEvent.loadReports() = LoadReports;
  const factory ReportsEvent.createReport(Map<String, dynamic> reportData) = CreateReport;
}
