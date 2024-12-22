abstract class HealthState {}

class HealthInitial extends HealthState {}

class HealthCalculated extends HealthState {
  final int healthScore;
  final String bloodSugarCategory;
  final String bloodPressureCategory;
  final double bloodPressureRatio;
  final String heartDiseaseRisk;
  final String idealGuidelines;
  final String bloodPressure;
  final String formattedBloodSugar;
  final String formattedBloodPressureRatio;

  HealthCalculated(
    this.healthScore,
    this.bloodSugarCategory,
    this.bloodPressureCategory,
    this.bloodPressureRatio,
    this.heartDiseaseRisk,
    this.idealGuidelines,
    this.bloodPressure,
    this.formattedBloodSugar,
    this.formattedBloodPressureRatio 
  );
}

class HealthError extends HealthState {
  final String message;

  HealthError(this.message);
}
