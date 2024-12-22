import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;  // Optional icon for the prefix

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.icon,  // Accept an optional icon parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        // Prefix icon (email or password)
        prefixIcon: icon != null ? Icon(icon, color: const Color.fromARGB(255, 120, 205, 242)) : null,

        // Border when unselected
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400), // Light gray border
          borderRadius: BorderRadius.circular(12),
        ),

        // Border when selected (focused)
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade500), // Blue border when focused
          borderRadius: BorderRadius.circular(12),
        ),

        // Hint text style
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600), // Darker hint text for readability

        // Text field background
        fillColor: Colors.grey.shade100, // Light gray background
        filled: true,
      ),
    );
  }
}
