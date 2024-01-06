import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _onUserNameChanged() {}

  void _onPasswordChanged() {}

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(_onUserNameChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _userNameController.removeListener(_onUserNameChanged);
    _passwordController.removeListener(_onPasswordChanged);
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(),
                    label: Text('Username'),
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
                _isLoading
                    ? const CircularProgressIndicator()
                    : FilledButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          Future.delayed(const Duration(seconds: 2), () {});
                          setState(() {
                            _isLoading = false;
                          });

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Successful!'),
                              ),
                            );
                          }
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text('LOG IN'),
                          ),
                        ),
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
    );
  }
}
