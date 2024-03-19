part of 'signup_bloc.dart';

sealed class SignupEvent {}

final class SignupSubmitted extends SignupEvent {
  final String email;
  final String password;
  final String username;

  SignupSubmitted({
    required this.email,
    required this.password,
    required this.username,
  });
}
