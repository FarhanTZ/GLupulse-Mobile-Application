import 'package:flutter/material.dart';

class HeartDiseaseCheckbox extends StatelessWidget {
  final bool hasHeartDisease;
  final ValueChanged<bool?> onChanged;

  const HeartDiseaseCheckbox({super.key, required this.hasHeartDisease, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox dengan bentuk lingkaran
        Checkbox(
          value: hasHeartDisease,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary, // Sesuaikan dengan tema
          shape: const CircleBorder(side: BorderSide(color: Colors.black)), // Menggunakan CircleBorder
        ),
        GestureDetector(
          onTap: () {
            onChanged(!hasHeartDisease); // Ketika teks diklik, status checkbox akan berubah
          },
          child: const Text(
            "Do you have a history of heart disease?",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
