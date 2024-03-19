part of 'login_out_bloc.dart';

sealed class LoginOutState {}

final class LoginInitial extends LoginOutState {}

final class LoginLoading extends LoginOutState {}

final class LoginSuccess extends LoginOutState {}

final class LoginFailure extends LoginOutState {
  final String error;

  LoginFailure(this.error);
}

final class LogoutLoading extends LoginOutState {}

final class LogoutSuccess extends LoginOutState {}

final class LogoutFailure extends LoginOutState {
  final String error;

  LogoutFailure(this.error);
}
