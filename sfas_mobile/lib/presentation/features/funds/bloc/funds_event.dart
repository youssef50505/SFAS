import 'package:freezed_annotation/freezed_annotation.dart';

part 'funds_event.freezed.dart';

@freezed
class FundsEvent with _$FundsEvent {
  const factory FundsEvent.loadFunds() = LoadFunds;
  const factory FundsEvent.createFund(Map<String, dynamic> fundData) = CreateFund;
  const factory FundsEvent.updateFundStatus(String fundId, String status) = UpdateFundStatus;
}
