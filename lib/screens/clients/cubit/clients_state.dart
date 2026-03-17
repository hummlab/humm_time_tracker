import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'clients_state.freezed.dart';

@freezed
class ClientsState with _$ClientsState {
  const factory ClientsState({
    @Default([]) List<Client> clients,
    @Default({}) Map<String, int> projectCountsByClientId,
    @Default(false) bool isProcessing,
    String? toastMessage,
    AppToastType? toastType,
  }) = _ClientsState;

  factory ClientsState.initial() => const ClientsState();
}
