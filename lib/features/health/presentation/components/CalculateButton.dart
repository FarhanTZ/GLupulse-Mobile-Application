import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CalculateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary, // Primary color tema
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        elevation: 5, // Menambahkan shadow untuk efek mengambang
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
      ),
      onPressed: onPressed,
      child: const Text(
        "Calculate Health Score",
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold, 
          color: Colors.white, // Mengatur warna teks menjadi putih
        ),
      ),
    );
  }
}
