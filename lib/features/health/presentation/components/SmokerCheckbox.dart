import 'package:flutter/material.dart';

class SmokerCheckbox extends StatelessWidget {
  final bool isSmoker;
  final ValueChanged<bool?> onChanged;

  const SmokerCheckbox({super.key, required this.isSmoker, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox dengan bentuk lingkaran
        Checkbox(
          value: isSmoker,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary, // Sesuaikan dengan tema
          shape: const CircleBorder(side: BorderSide(color: Colors.black)), // Menggunakan CircleBorder
        ),
        GestureDetector(
          onTap: () {
            onChanged(!isSmoker); // Ketika teks diklik, status checkbox akan berubah
          },
          child: const Text(
            "Are you a smoker?",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
