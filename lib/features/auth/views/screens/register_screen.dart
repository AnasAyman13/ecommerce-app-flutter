import 'package:flutter/material.dart';
import '../../../../core/routing/app_route_names.dart';
import '../widgets/login_button.dart';
import '../widgets/login_text_field.dart';
import '../widgets/register_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool isAccepted = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  void register() {
    if (!_formKey.currentState!.validate()) return;

    if (!isAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please accept the Terms & Privacy Policy"),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account Created Successfully")),
    );

    Navigator.pushReplacementNamed(context, AppRouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 420,

            child: SingleChildScrollView(
              child: Form(
                key: _formKey,

                child: Column(
                  children: [
                    const RegisterHeader(),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          LoginTextField(
                            title: "NAME",
                            hint: "Enter your name",
                            icon: Icons.person_outline,
                            controller: nameController,

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          LoginTextField(
                            title: "EMAIL",
                            hint: "Enter your email",
                            icon: Icons.email_outlined,
                            controller: emailController,

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }

                              if (!value.contains("@")) {
                                return "Invalid email";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          LoginTextField(
                            title: "PASSWORD",
                            hint: "Create password",
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
                                return "Please enter password";
                              }

                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          LoginTextField(
                            title: "CONFIRM PASSWORD",

                            hint: "Confirm password",

                            icon: Icons.lock_outline,

                            controller: confirmPasswordController,

                            obscure: isConfirmPasswordHidden,

                            onTogglePassword: () {
                              setState(() {
                                isConfirmPasswordHidden =
                                    !isConfirmPasswordHidden;
                              });
                            },

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please confirm password";
                              }

                              if (value != passwordController.text) {
                                return "Passwords do not match";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isAccepted,
                                activeColor: const Color(0xff8F4040),
                                onChanged: (value) {
                                  setState(() {
                                    isAccepted = value!;
                                  });
                                },
                              ),
                              Expanded(
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 13,
                                      height: 1.5,
                                    ),
                                    children: [
                                      TextSpan(text: "I agree to the "),
                                      TextSpan(
                                        text: "Terms of Service",
                                        style: TextStyle(
                                          color: Color(0xff8F4040),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: " and "),
                                      TextSpan(
                                        text: "Privacy Policy",
                                        style: TextStyle(
                                          color: Color(0xff8F4040),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          LoginButton(onPressed: register),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Text("Already have an account?"),

                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRouteNames.login,
                                  );
                                },

                                child: const Text("Login"),
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
      ),
    );
  }
}
