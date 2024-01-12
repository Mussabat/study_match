import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_match/app.dart';
import 'package:study_match/auth/authentication.dart';
import 'package:study_match/constants/supabase_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: SupabaseConstants.supabaseUrl,
    anonKey: SupabaseConstants.supabaseKey,
  );
  runApp(
    BlocProvider(
      create: (context) => LoginOutBloc(),
      child: const MyApp(),
    ),
  );
}
