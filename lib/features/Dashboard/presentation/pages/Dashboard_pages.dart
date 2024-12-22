import 'package:flutter/material.dart';
import 'package:finpro/features/Dashboard/presentation/componet/Header.dart';
import 'package:finpro/features/Dashboard/presentation/componet/Healt_score_Card.dart';
import 'package:finpro/features/Dashboard/presentation/componet/Smart_healt_metric_Card.dart';
import 'package:finpro/features/Dashboard/presentation/componet/HealthFoodRecommendationCard.dart'; // Import new component
import '../componet/HealthAktivityRecommendationCard.dart'; // Import ActivityRecommendationCard

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          HeaderCard(),
          SizedBox(height: 15),
          HealthScoreCard(),
          SmartHealthMetrics(),
          HealthFoodRecommendationCard(),
          ActivityRecommendationCard(), // Add the ActivityRecommendationCard component here
        ],
      ),
    );
  }
}
