import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finpro/features/auth/presentation/components/my_buttom.dart';
import 'package:finpro/features/auth/presentation/components/my_text_field.dart';
import 'package:finpro/features/auth/presentation/cubits/auth.cubit.dart';

class LoginPages extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPages({super.key, required this.togglePages});

  @override
  State<LoginPages> createState() => _LoginPages();
}

class _LoginPages extends State<LoginPages> {
  // Text controllers
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  // Login function
  void login() {
    final String email = emailController.text;
    final String pw = pwController.text;
    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && pw.isNotEmpty) {
      // Attempt login
      authCubit.login(email, pw);
    } else {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter both email and password'),
      ));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // White background
      body: SafeArea(
        child: Container(
          color: Colors.white,  // Set background to white
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Icon
                  Icon(
                    Icons.lock_open_rounded,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 50),

                  // Welcome message
                  Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Email text field
                  MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                  icon: Icons.email,  // Email icon
                  ),

                  const SizedBox(height: 10),

                  // Password text field
                  MyTextField(
                  controller: pwController,
                  hintText: "Password",
                  obscureText: true,
                  icon: Icons.lock,  // Password icon
                    ),

                  const SizedBox(height: 25),

                  // Login Button
                  MyButtom(
                    onTap: login,
                    text: "Login",
                  ),

                  const SizedBox(height: 50),

                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member? Register now!",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.togglePages,
                        child: Text(
                          " Register now",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
