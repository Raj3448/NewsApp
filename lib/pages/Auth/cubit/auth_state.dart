part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthGetSuccess extends AuthState {
  String verificationCode;
  AuthGetSuccess({required this.verificationCode});
}

final class AuthSuccess extends AuthState{}

final class AuthFailure extends AuthState {
  String error;
  AuthFailure({required this.error});
}
