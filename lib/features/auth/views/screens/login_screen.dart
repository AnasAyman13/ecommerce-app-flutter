import 'package:flutter/material.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../viewmodels/auth_view_model.dart';
import '../widgets/login_button.dart';
import '../widgets/login_header.dart';
import '../widgets/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (!_formKey.currentState!.validate() || isLoading) return;
    _submitLogin();
  }

  Future<void> _submitLogin() async {
    setState(() => isLoading = true);
    try {
      await sl<AuthViewModel>().login(
        email: emailController.text,
        password: passwordController.text,
      );
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteNames.home,
        (_) => false,
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width > 500
              ? 420
              : double.infinity,

          child: SingleChildScrollView(
            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  const LoginHeader(),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        LoginTextField(
                          title: "EMAIL",

                          hint: "Enter your email",

                          icon: Icons.email_outlined,

                          controller: emailController,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }

                            if (!RegExp(
                              r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                            ).hasMatch(value)) {
                              return "Invalid email";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        LoginTextField(
                          title: "PASSWORD",

                          hint: "Enter your password",

                          icon: Icons.lock_outline,

                          controller: passwordController,

                          obscure: isPasswordHidden,

                          onTogglePassword: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }

                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }

                            if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
                                !RegExp(r'\d').hasMatch(value)) {
                              return "Use letters and at least one number";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerRight,

                          child: TextButton(
                            onPressed: () {
                              // Forgot Password later
                            },

                            child: const Text("Forgot Password?"),
                          ),
                        ),

                        const SizedBox(height: 20),

                        LoginButton(onPressed: login),

                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRouteNames.home,
                              (_) => false,
                            ),
                            icon: const Icon(Icons.person_outline),
                            label: const Text('Continue as Guest'),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text("New to NORR?"),

                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,

                                  AppRouteNames.register,
                                );
                              },

                              child: const Text("Create Account"),
                            ),
                          ],
                        ),
                      ],
                    ),
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
