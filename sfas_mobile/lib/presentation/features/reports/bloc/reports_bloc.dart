import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/report_repository.dart';
import 'reports_event.dart';
import 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ReportRepository _reportRepository;

  ReportsBloc({required ReportRepository reportRepository})
      : _reportRepository = reportRepository,
        super(const ReportsState.initial()) {
    on<ReportsEvent>((event, emit) async {
      await event.map(
        loadReports: (_) => _onLoadReports(emit),
        createReport: (e) => _onCreateReport(e.reportData, emit),
      );
    });
  }

  Future<void> _onLoadReports(Emitter<ReportsState> emit) async {
    emit(const ReportsState.loading());
    try {
      final reports = await _reportRepository.getReports();
      emit(ReportsState.loaded(reports));
    } catch (e) {
      emit(ReportsState.error(e.toString()));
    }
  }

  Future<void> _onCreateReport(Map<String, dynamic> reportData, Emitter<ReportsState> emit) async {
    try {
      await _reportRepository.createReport(reportData);
      add(const ReportsEvent.loadReports());
    } catch (e) {
      emit(ReportsState.error(e.toString()));
    }
  }
}
