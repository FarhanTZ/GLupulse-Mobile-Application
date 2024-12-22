import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../health/presentation/pages/health_input_page.dart';

class HealthAnalyticsPage extends StatefulWidget {
  const HealthAnalyticsPage({super.key});

  @override
  _HealthAnalyticsPageState createState() => _HealthAnalyticsPageState();
}

class _HealthAnalyticsPageState extends State<HealthAnalyticsPage> { 
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // To remove the back button if it's shown
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // StreamBuilder untuk data analitik
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .collection('health_data')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Tidak ada data kesehatan ditemukan."),
                  );
                }

                final latestHealthData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                final healthScore = (latestHealthData['healthScore'] ?? 0).toDouble();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0), // Mengurangi vertical padding agar lebih ke atas
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Health Score Section dengan Percent Indicator
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Health Score",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Percent Indicator
                              CircularPercentIndicator(
                                radius: 70.0,
                                lineWidth: 12.0,
                                percent: healthScore / 100,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      healthScore.toInt().toString(),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      "Out of 100",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                progressColor: Colors.greenAccent,
                                backgroundColor: Colors.white10,
                                circularStrokeCap: CircularStrokeCap.round,
                              ),
                              const SizedBox(height: 20),

                              // Tombol untuk berpindah ke halaman input health
                              TextButton(
                                onPressed: () {
                                  // Arahkan ke halaman Input Health
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HealthInputPage()),
                                  );
                                },
                                child: const Text(
                                  'Input Health',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Analytic Cards Section
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: [
                            const Text("Smart Health Metrics",
                                  style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.w600),),
                              const SizedBox(height: 26),
                            _buildParameterCard(
                              title: "Gula Darah",
                              subtitle: "${latestHealthData['bloodsugar'] ?? 'N/A'}",
                              status: "Normal",
                              color: Colors.green,
                              icon: Icons.bloodtype,
                            ),
                            _buildParameterCard(
                              title: "Tekanan Darah",
                              subtitle: "${latestHealthData['Bloodpressure'] ?? 'N/A'}",
                              status: "Critical",
                              color: Colors.red,
                              icon: Icons.favorite,
                            ),
                            _buildParameterCard(
                              title: "Category Gula Darah",
                              subtitle: "${latestHealthData['bloodSugarCategory'] ?? 'N/A'}",
                              status: "Critical",
                              color: Colors.red,
                              icon: Icons.bloodtype,
                            ),
                            _buildParameterCard(
                              title: "Category Tekanan Darah",
                              subtitle: "${latestHealthData['bloodPressureCategory'] ?? 'N/A'}",
                              status: "Normal",
                              color: Colors.green,
                              icon: Icons.favorite,
                            ),
                            _buildParameterCard(
                              title: "Rasio Tekanan Darah",
                              subtitle: "${latestHealthData['bloodPressureRatio'] ?? 'N/A'}",
                              status: "Normal",
                              color: Colors.green,
                              icon: Icons.speed,
                            ),
                            _buildParameterCard(
                              title: "Risiko Jantung",
                              subtitle: "${latestHealthData['heartDiseaseRisk'] ?? 'N/A'}",
                              status: "Critical",
                              color: Colors.orange,
                              icon: Icons.warning,
                            ),
                          ],
                        ),

                        // Menampilkan Health History jika _isHealthHistoryVisible bernilai true

                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat kartu parameter
  Widget _buildParameterCard({
    required String title,
    required String subtitle,
    required String status,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: color),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
