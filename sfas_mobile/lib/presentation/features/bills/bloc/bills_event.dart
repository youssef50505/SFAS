import 'package:freezed_annotation/freezed_annotation.dart';

part 'bills_event.freezed.dart';

@freezed
class BillsEvent with _$BillsEvent {
  const factory BillsEvent.loadBills() = LoadBills;
  const factory BillsEvent.createBill(Map<String, dynamic> billData) = CreateBill;
  const factory BillsEvent.updateBillStatus(String billId, String status, {String? reviewComments}) = UpdateBillStatus;
}
