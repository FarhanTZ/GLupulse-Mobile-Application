import 'package:finpro/features/health/presentation/cubits/health_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/pages/home_pages.dart';
import '../components/CalculateButton.dart';
import '../components/HeartDiseaseCheckbox.dart';
import '../components/InputTextField.dart';
import '../components/SmokerCheckbox.dart';// Pastikan untuk mengimpor halaman ini

class HealthInputPage extends StatefulWidget {
  const HealthInputPage({super.key});

  @override
  _HealthInputPageState createState() => _HealthInputPageState();
}

class _HealthInputPageState extends State<HealthInputPage> {
  final bloodSugarController = TextEditingController();
  final systolicBPController = TextEditingController();
  final diastolicBPController = TextEditingController();

  bool isSmoker = false;
  bool hasHeartDisease = false;

  // Mendapatkan userId dari Firebase Authentication
  String getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? 'guest';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Health Score Calculator")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Label dan Input untuk Blood Sugar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Blood Sugar (mg/dL)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                InputTextField(
                  controller: bloodSugarController,
                  label: "Blood Sugar",
                  hintText: "Enter blood sugar",
                ),
                const SizedBox(height: 16),
              ],
            ),

            // Label dan Input untuk Systolic BP
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Systolic Blood Pressure (mmHg)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                InputTextField(
                  controller: systolicBPController,
                  label: "Systolic BP",
                  hintText: "Enter systolic BP",
                ),
                const SizedBox(height: 16),
              ],
            ),

            // Label dan Input untuk Diastolic BP
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Diastolic Blood Pressure (mmHg)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                InputTextField(
                  controller: diastolicBPController,
                  label: "Diastolic BP",
                  hintText: "Enter diastolic BP",
                ),
                const SizedBox(height: 16),
              ],
            ),

            // Smoker Checkbox
            SmokerCheckbox(
              isSmoker: isSmoker,
              onChanged: (value) {
                setState(() {
                  isSmoker = value!;
                });
              },
            ),
            const SizedBox(height: 10),

            // Heart Disease Checkbox
            HeartDiseaseCheckbox(
              hasHeartDisease: hasHeartDisease,
              onChanged: (value) {
                setState(() {
                  hasHeartDisease = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Calculate Button
            CalculateButton(
              onPressed: () {
                final bloodSugar = int.tryParse(bloodSugarController.text) ?? 0;
                final systolicBP = int.tryParse(systolicBPController.text) ?? 0;
                final diastolicBP = int.tryParse(diastolicBPController.text) ?? 0;

                // Memanggil fungsi dari HealthCubit untuk menghitung health score
                context.read<HealthCubit>().calculateHealthScore(
                  bloodSugar,
                  systolicBP,
                  diastolicBP,
                  isSmoker,
                  hasHeartDisease,
                );

                // Navigasi ke halaman HealthAnalyticsPage setelah kalkulasi selesai
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePages()),
                );
              },
            ),
            const SizedBox(height: 20),

            // Displaying health score and other details
          ],
        ),
      ),
    );
  }
}
