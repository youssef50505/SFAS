import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/models/bill.dart';

part 'bills_state.freezed.dart';

@freezed
class BillsState with _$BillsState {
  const factory BillsState.initial() = _Initial;
  const factory BillsState.loading() = _Loading;
  const factory BillsState.loaded(List<Bill> bills) = _Loaded;
  const factory BillsState.error(String message) = _Error;
}
