import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final supabase = Supabase.instance.client;

  User? getUser() {
    return supabase.auth.currentUser;
  }
}
