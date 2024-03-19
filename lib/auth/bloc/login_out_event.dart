part of 'login_out_bloc.dart';

sealed class LoginOutEvent {}

final class LoginSubmitted extends LoginOutEvent {
  final String email;
  final String password;

  LoginSubmitted({
    required this.email,
    required this.password,
  });
}

final class LogoutSubmitted extends LoginOutEvent {}
