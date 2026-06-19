import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/fund_repository.dart';
import 'funds_event.dart';
import 'funds_state.dart';

class FundsBloc extends Bloc<FundsEvent, FundsState> {
  final FundRepository _fundRepository;

  FundsBloc({required FundRepository fundRepository})
      : _fundRepository = fundRepository,
        super(const FundsState.initial()) {
    on<FundsEvent>((event, emit) async {
      await event.map(
        loadFunds: (_) => _onLoadFunds(emit),
        createFund: (e) => _onCreateFund(e.fundData, emit),
        updateFundStatus: (e) => _onUpdateFundStatus(e.fundId, e.status, e.reviewComments, emit),
      );
    });
  }

  Future<void> _onLoadFunds(Emitter<FundsState> emit) async {
    emit(const FundsState.loading());
    try {
      final funds = await _fundRepository.getFunds();
      emit(FundsState.loaded(funds));
    } catch (e) {
      emit(FundsState.error(e.toString()));
    }
  }

  Future<void> _onCreateFund(Map<String, dynamic> fundData, Emitter<FundsState> emit) async {
    try {
      await _fundRepository.createFund(fundData);
      add(const FundsEvent.loadFunds());
    } catch (e) {
      emit(FundsState.error(e.toString()));
    }
  }

  Future<void> _onUpdateFundStatus(String fundId, String status, String? reviewComments, Emitter<FundsState> emit) async {
    try {
      await _fundRepository.updateFundStatus(fundId, status, reviewComments: reviewComments);
      add(const FundsEvent.loadFunds());
    } catch (e) {
      emit(FundsState.error(e.toString()));
    }
  }
}
