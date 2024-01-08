import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_match/auth/bloc/bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginOutBloc(),
      child: Scaffold(
        body: Center(
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Log In to Study Match',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25,
                        // color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.002,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'We are glad that you are here. Let\'s get started!',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      label: Text('email'),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                      label: Text('Password'),
                    ),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  BlocConsumer<LoginOutBloc, LoginOutState>(
                    listener: (context, state) {
                      if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }

                      if (state is LoginSuccess) {
                        context.goNamed('home');
                      }
                    },
                    builder: (context, state) {
                      return state is LoginLoading
                          ? const CircularProgressIndicator()
                          : FilledButton(
                              onPressed: () {
                                context.read<LoginOutBloc>().add(
                                      LoginSubmitted(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              },
                              child: const SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text('LOG IN'),
                                ),
                              ),
                            );
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.002),
                  TextButton(
                    child: const Text('Create an account'),
                    onPressed: () => context.goNamed('sign_up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
