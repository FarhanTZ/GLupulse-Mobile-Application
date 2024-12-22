class HealthData {
  final int healthScore;
  final String bloodSugarCategory;
  final String bloodPressureCategory;
  final double bloodPressureRatio;
  final String heartDiseaseRisk;
  final String idealGuidelines;
  
  HealthData({
    required this.healthScore,
    required this.bloodSugarCategory,
    required this.bloodPressureCategory,
    required this.bloodPressureRatio,
    required this.heartDiseaseRisk,
    required this.idealGuidelines,
  });

  factory HealthData.fromFirestore(Map<String, dynamic> data) {
    return HealthData(
      healthScore: data['healthScore'] ?? 0,
      bloodSugarCategory: data['bloodSugarCategory'] ?? '',
      bloodPressureCategory: data['bloodPressureCategory'] ?? '',
      bloodPressureRatio: data['bloodPressureRatio'] ?? 0.0,
      heartDiseaseRisk: data['heartDiseaseRisk'] ?? '',
      idealGuidelines: data['idealGuidelines'] ?? '',
    );
  }
}
