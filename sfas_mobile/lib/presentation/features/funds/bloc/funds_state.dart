import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/models/fund.dart';

part 'funds_state.freezed.dart';

@freezed
class FundsState with _$FundsState {
  const factory FundsState.initial() = _Initial;
  const factory FundsState.loading() = _Loading;
  const factory FundsState.loaded(List<Fund> funds) = _Loaded;
  const factory FundsState.error(String message) = _Error;
}
