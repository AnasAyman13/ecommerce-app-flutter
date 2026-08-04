import 'package:flutter/material.dart';

import '../../../../routes/app_routes.dart';
import '../widgets/login_button.dart';
import '../widgets/login_header.dart';
import '../widgets/login_text_field.dart';
import '../widgets/social_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();


  bool isPasswordHidden = true;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  void login() {

    if (_formKey.currentState!.validate()) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Success"),
        ),
      );

    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Center(

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

                        crossAxisAlignment:
                        CrossAxisAlignment.start,


                        children: [



                          LoginTextField(

                            title: "EMAIL",

                            hint: "Enter your email",

                            icon: Icons.email_outlined,

                            controller: emailController,


                            validator: (value) {

                              if(value == null || value.isEmpty){

                                return "Please enter your email";

                              }


                              if(!value.contains("@")){

                                return "Invalid email";

                              }


                              return null;

                            },

                          ),



                          const SizedBox(height:20),




                          LoginTextField(

                            title: "PASSWORD",

                            hint: "Enter your password",

                            icon: Icons.lock_outline,

                            controller: passwordController,


                            obscure: isPasswordHidden,


                            onTogglePassword: (){

                              setState(() {

                                isPasswordHidden =
                                !isPasswordHidden;

                              });

                            },


                            validator:(value){

                              if(value == null || value.isEmpty){

                                return "Please enter your password";

                              }


                              if(value.length < 6){

                                return "Password must be at least 6 characters";

                              }


                              return null;

                            },


                          ),




                          const SizedBox(height:10),




                          Align(

                            alignment: Alignment.centerRight,


                            child: TextButton(

                              onPressed: (){

                                // Forgot Password later

                              },


                              child: const Text(
                                  "Forgot Password?"
                              ),

                            ),

                          ),




                          const SizedBox(height:20),




                          LoginButton(

                            onPressed: login,

                          ),





                          const SizedBox(height:24),




                          const Row(

                            children: [


                              Expanded(
                                  child: Divider()
                              ),


                              Padding(

                                padding: EdgeInsets.symmetric(
                                    horizontal:10
                                ),


                                child: Text(

                                  "Or continue with",

                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),

                                ),

                              ),


                              Expanded(
                                  child: Divider()
                              ),


                            ],

                          ),




                          const SizedBox(height:24),





                          Row(

                            children: [


                              Expanded(

                                child: SocialButton(

                                  icon: Icons.g_mobiledata,

                                  title: "Google",

                                  onPressed: (){},

                                ),

                              ),



                              const SizedBox(width:10),



                              Expanded(

                                child: SocialButton(

                                  icon: Icons.apple,

                                  title: "Apple",

                                  onPressed: (){},

                                ),

                              ),




                              const SizedBox(width:10),




                              Expanded(

                                child: SocialButton(

                                  icon: Icons.facebook,

                                  title: "Meta",

                                  onPressed: (){},

                                ),

                              ),


                            ],

                          ),





                          const SizedBox(height:24),





                          Row(

                            mainAxisAlignment:
                            MainAxisAlignment.center,


                            children: [


                              const Text(
                                  "New to NORR?"
                              ),



                              TextButton(

                                onPressed: (){


                                  Navigator.pushNamed(

                                    context,

                                    AppRoutes.register,

                                  );


                                },


                                child: const Text(
                                    "Create Account"
                                ),

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