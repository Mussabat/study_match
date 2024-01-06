import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<(Session?, User?, AuthException?)> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email.trim(),
        password: password.trim(),
        data: {'username': username.trim()},
      );

      Session? session = response.session;
      User? user = response.user;

      return (session, user, null);
    } on AuthException catch (e) {
      return (null, null, e);
    }
  }
}
