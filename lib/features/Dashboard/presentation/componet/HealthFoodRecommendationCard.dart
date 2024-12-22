// File: HealthFoodRecommendationCard.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../health/domain/repos/health_recommendations.dart';
import '../../../menu makanan/presentation/models/food.dart';
import '../../../menu makanan/presentation/models/restaurant.dart';
import '../../../menu makanan/presentation/pages/food_pages.dart';

class HealthFoodRecommendationCard extends StatelessWidget {
  const HealthFoodRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ambil data healthScore dari Firestore
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
              final healthScore = (latestHealthData['healthScore'] ?? 0).toDouble();

              // Buat instance dari Restaurant dan HealthRecommendation untuk rekomendasi makanan
              final restaurant = Restaurant();
              final healthRecommendation = HealthRecommendation(restaurant);

              // Dapatkan makanan yang direkomendasikan berdasarkan health score
              List<Food> recommendedFoods = healthRecommendation.getRecommendedFood(healthScore);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Memastikan teks align kiri
                children: [
                  // Menampilkan teks "Recommended Foods" di kiri
                  const Align(
                    alignment: Alignment.centerLeft, // Teks rata kiri
                    child: Text(
                      "Recommended Foods",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Daftar makanan dalam bentuk card yang bisa digeser
                  SizedBox(
                    height: 300, // Atur tinggi untuk setiap card
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Mengubah scroll ke horizontal
                      itemCount: recommendedFoods.length,
                      itemBuilder: (context, index) {
                        final food = recommendedFoods[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodPages(food: food),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                width: 200, // Ukuran card
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Gambar makanan dengan sudut circular
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15), // Ujung gambar melengkung
                                      child: Image.asset(
                                        food.imagePath,
                                        width: 180,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Nama makanan
                                    Text(
                                      food.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Deskripsi makanan
                                    Text(
                                      food.description,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 8),
                                    // Harga makanan
                                    Text(
                                      "\$${food.price.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
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
