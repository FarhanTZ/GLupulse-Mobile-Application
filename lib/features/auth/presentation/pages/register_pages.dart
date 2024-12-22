import 'package:finpro/features/auth/presentation/cubits/auth.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/my_buttom.dart';
import '../components/my_text_field.dart';

class RegisterPages extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPages({super.key, required this.togglePages});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  
  // Text controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  // Register button pressed
  void register() {
    // Prepare info
    final String name = nameController.text;
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;

    // Auth cubit
    final authCubit = context.read<AuthCubit>();

    // Ensure the fields aren't empty
    if (email.isNotEmpty && 
        name.isNotEmpty && 
        pw.isNotEmpty && 
        confirmPw.isNotEmpty) {

      // Ensure password match
      if (pw == confirmPw) {
        authCubit.register(name, email, pw);
      } else {
        // Password do not match
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password do not match!"))
        );
      }
    } else {
      // Fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please Complete all fields")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Set background to white
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
            
                const SizedBox(height: 50),
            
                // Create account text
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // Name text field
                MyTextField(
                  controller: nameController, 
                  hintText: "Name", 
                  obscureText: false
                ),
            
                const SizedBox(height: 10),
            
                // Email text field
                MyTextField(
                  controller: emailController, 
                  hintText: "Email", 
                  obscureText: false
                ),
            
                const SizedBox(height: 10),
                
                // Password text field
                MyTextField(
                  controller: pwController, 
                  hintText: "Password", 
                  obscureText: true,
                ),
            
                const SizedBox(height: 10),
                
                // Confirm Password text field
                MyTextField(
                  controller: confirmPwController, 
                  hintText: "Confirm password", 
                  obscureText: true,
                ),
            
                const SizedBox(height: 25),
            
                // Register button
                MyButtom(
                  onTap: register,
                  text: "Register",
                ),
            
                const SizedBox(height: 50),
            
                // Already a member? Login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member? ", 
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                    )),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        "Login now", 
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
    );
  }
}
