import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finpro/features/health/presentation/cubits/health_cubit.dart';
import 'package:finpro/features/health/presentation/cubits/health_states.dart';

class HealthResultDisplay extends StatelessWidget {
  const HealthResultDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthCubit, HealthState>(
      builder: (context, state) {
        if (state is HealthInitial) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Enter values to calculate health score.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          );
        } else if (state is HealthCalculated) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildResultCard("Health Score", "${state.healthScore}", Icons.health_and_safety),
                _buildResultCard("Blood Sugar Category", state.bloodSugarCategory, Icons.local_hospital),
                _buildResultCard("Blood Pressure Category", state.bloodPressureCategory, Icons.accessibility_new),
                _buildResultCard("Blood Pressure Ratio", state.bloodPressureRatio.toStringAsFixed(2), Icons.trending_up),
                _buildResultCard("Heart Disease Risk", state.heartDiseaseRisk, Icons.favorite),
                _buildResultCard("Ideal Health Guidelines", state.idealGuidelines, Icons.check_circle_outline),
              ],
            ),
          );
        } else if (state is HealthError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Error: ${(state).message}",
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
