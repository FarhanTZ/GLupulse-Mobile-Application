import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../health/domain/repos/ActivityRecommendation.dart';

class ActivityRecommendationCard extends StatelessWidget {
  const ActivityRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stream untuk mengambil data healthScore dan kategori dari Firestore
          StreamBuilder<DocumentSnapshot>(
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
              final healthScore = (latestHealthData['healthScore'] ?? 0).toInt();
              final bloodSugarCategory = latestHealthData['bloodSugarCategory'] ?? 'Normal';
              final bloodPressureCategory = latestHealthData['bloodPressureCategory'] ?? 'Normal';

              // Membuat instance ActivityRecommendation untuk mendapatkan rekomendasi aktivitas
              final activityRecommendation = ActivityRecommendation();
              final recommendedActivities = activityRecommendation.recommendActivities(
                healthScore,
                bloodSugarCategory,
                bloodPressureCategory,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Recommended Activities",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Daftar aktivitas dalam bentuk card
                  SizedBox(
                    height: 300, // Set height for activity cards
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Horizontal scroll
                      itemCount: recommendedActivities.length,
                      itemBuilder: (context, index) {
                        final activity = recommendedActivities[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              width: 200, // Set width for activity card
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15), // Round corners
                                    child: Image.asset(
                                      activity.imageUrl,
                                      width: 180,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    activity.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    activity.description,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
