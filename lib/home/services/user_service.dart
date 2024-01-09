import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  UserService._();

  final supabase = Supabase.instance.client;

  User? getUser() {
    return supabase.auth.currentUser;
  }

  static final instance = UserService._();
}
