part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginRequested(String email, String password) = _LoginRequested;
  const factory AuthEvent.logoutRequested() = _LogoutRequested;
}
