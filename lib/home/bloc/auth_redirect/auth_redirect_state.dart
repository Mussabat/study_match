part of 'auth_redirect_bloc.dart';

sealed class AuthRedirectState {}

final class AuthRedirectInitial extends AuthRedirectState {}

final class AuthRedirectAuthenticated extends AuthRedirectState {
  AuthRedirectAuthenticated({required this.user});

  final User user;
}

final class AuthRedirectUnauthenticated extends AuthRedirectState {}
