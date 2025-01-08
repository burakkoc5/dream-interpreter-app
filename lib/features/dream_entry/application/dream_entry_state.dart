import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/dream_entry_model.dart';

part 'dream_entry_state.freezed.dart';

@freezed
class DreamEntryState with _$DreamEntryState {
  const factory DreamEntryState.initial() = _Initial;
  const factory DreamEntryState.loading() = _Loading;
  const factory DreamEntryState.success(DreamEntry dreamEntry) = _Success;
  const factory DreamEntryState.error(String message) = _Error;
}
