import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/bill_repository.dart';
import 'bills_event.dart';
import 'bills_state.dart';

class BillsBloc extends Bloc<BillsEvent, BillsState> {
  final BillRepository _billRepository;

  BillsBloc({required BillRepository billRepository})
      : _billRepository = billRepository,
        super(const BillsState.initial()) {
    on<BillsEvent>((event, emit) async {
      await event.map(
        loadBills: (_) => _onLoadBills(emit),
        createBill: (e) => _onCreateBill(e.billData, emit),
        updateBillStatus: (e) => _onUpdateBillStatus(e.billId, e.status, e.reviewComments, emit),
      );
    });
  }

  Future<void> _onLoadBills(Emitter<BillsState> emit) async {
    emit(const BillsState.loading());
    try {
      final bills = await _billRepository.getBills();
      emit(BillsState.loaded(bills));
    } catch (e) {
      emit(BillsState.error(e.toString()));
    }
  }

  Future<void> _onCreateBill(Map<String, dynamic> billData, Emitter<BillsState> emit) async {
    try {
      await _billRepository.createBill(billData);
      add(const BillsEvent.loadBills());
    } catch (e) {
      emit(BillsState.error(e.toString()));
    }
  }

  Future<void> _onUpdateBillStatus(String billId, String status, String? reviewComments, Emitter<BillsState> emit) async {
    try {
      await _billRepository.updateBillStatus(billId, status, reviewComments: reviewComments);
      add(const BillsEvent.loadBills());
    } catch (e) {
      emit(BillsState.error(e.toString()));
    }
  }
}
