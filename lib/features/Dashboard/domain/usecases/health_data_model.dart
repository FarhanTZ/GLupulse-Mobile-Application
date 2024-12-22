class HealthData {
  final double healthScore;
  final String idealGuidelines;

  HealthData({required this.healthScore, required this.idealGuidelines});

  // Factory constructor untuk mengonversi data dari Firestore menjadi objek HealthData
  factory HealthData.fromFirestore(Map<String, dynamic> data) {
    return HealthData(
      healthScore: data['healthScore']?.toDouble() ?? 0.0,
      idealGuidelines: data['idealGuidelines'] ?? '',
    );
  }
}
