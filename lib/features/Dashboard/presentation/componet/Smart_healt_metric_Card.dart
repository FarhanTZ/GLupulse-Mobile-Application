import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class SmartHealthMetrics extends StatelessWidget {
  const SmartHealthMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Smart Health Metrics",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 260,
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .collection('health_data')
                  .orderBy('timestamp', descending: true)
                  .limit(1)
                  .snapshots()
                  .map((event) => event.docs.first),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                    child: Text("Tidak ada data kesehatan ditemukan."),
                  );
                }

                final latestHealthData = snapshot.data!.data() as Map<String, dynamic>;

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Card Blood Sugar
                    _buildCard(
                      icon: Icons.bloodtype,
                      title: "Blood Sugar",
                      subtitle: "${latestHealthData['bloodsugar'] ?? 'N/A'}",
                      color: Colors.blueAccent, // Card warna biru
                      animationPath: 'assets/animation/Barchart.json', // Ganti dengan path animasi
                    ),
                    const SizedBox(width: 11),
                    // Card Blood Pressure
                    _buildCard(
                      icon: Icons.heart_broken,
                      title: "Blood Pressure",
                      subtitle: "${latestHealthData['Bloodpressure'] ?? 'N/A'}",
                      color: Colors.redAccent, // Card warna merah
                      animationPath: 'assets/animation/Barchart.json', // Ganti dengan path animasi
                    ),
                    const SizedBox(width: 11),
                    // Card Blood Sugar Category
                    _buildCard(
                      icon: Icons.category,
                      title: "Category\nBlood Sugar",
                      subtitle: "${latestHealthData['bloodSugarCategory'] ?? 'N/A'}",
                      color: Colors.lightBlueAccent, // Card warna biru muda transparan
                      animationPath: 'assets/animation/Barchart.json', // Ganti dengan path animasi
                    ),
                    const SizedBox(width: 11),
                    // Card Blood Pressure Category
                    _buildCard(
                      icon: Icons.favorite,
                      title: "Category\nBlood Pressure",
                      subtitle: "${latestHealthData['bloodPressureCategory'] ?? 'N/A'}",
                      color: Colors.lightGreenAccent, // Card warna hijau terang
                      animationPath: 'assets/animation/Barchart.json', // Ganti dengan path animasi
                    ),
                    const SizedBox(width: 11),
                    // Card Blood Pressure Ratio
                    _buildCard(
                      icon: Icons.speed,
                      title: "Blood Pressure\nRatio",
                      subtitle: "${latestHealthData['bloodPressureRatio'] ?? 'N/A'}",
                      color: Colors.tealAccent, // Card warna teal terang
                      animationPath: 'assets/animation/Barchart.json', // Ganti dengan path animasi
                    ),
                    const SizedBox(width: 11),
                    // Card Heart Disease Risk
                    _buildCard(
                      icon: Icons.warning,
                      title: "Heart Disease Risk",
                      subtitle: "${latestHealthData['heartDiseaseRisk'] ?? 'N/A'}",
                      color: Colors.orangeAccent, // Card warna orange terang
                      animationPath: 'assets/animation/Barchart.json', // Ganti dengan path animasi
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat kartu parameter dengan layout baru
  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required String animationPath, // Menambahkan parameter path animasi
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Teks di kiri
          children: [
            // Teks Title di kiri atas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Membuat elemen berjauhan
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  icon,
                  size: 22, // Ukuran ikon lebih kecil
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 0.1), // Jarak setelah title dan icon
            // Animasi Lottie di tengah
            Expanded(
              child: Center(
                child: Lottie.asset(
                  animationPath, // Path animasi
                  width: 100, // Ukuran animasi
                  height: 100,
                  fit: BoxFit.cover,
                  repeat: false,
                  animate: false,
                ),
              ),
            ),
            // Hasil di bawah dengan teks lebih besar dan bold
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 20, // Ukuran teks diperbesar
                fontWeight: FontWeight.bold, // Membuat teks menjadi bold
                color: Colors.white, // Teks berwarna putih
              ),
            ),
          ],
        ),
      ),
    );
  }
}
