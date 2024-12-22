import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finpro/features/health/presentation/cubits/health_states.dart'; // Import health states
import '../../domain/repos/health_calculator_repo.dart'; // Import HealthCalculatorRepo

class HealthCubit extends Cubit<HealthState> {
  final HealthCalculatorRepo _healthCalculatorRepo;
  final FirebaseFirestore _firestore;

  HealthCubit(this._healthCalculatorRepo, this._firestore) : super(HealthInitial());

  

  
  // Method to calculate health score
  void calculateHealthScore(
    int bloodSugar  , 
    int systolicBP, 
    int diastolicBP, 
    bool isSmoker, 
    bool hasHeartDisease
  ) async {
    try {
      // Hitung health score dengan tambahan parameter isSmoker dan hasHeartDisease
      int healthScore = _healthCalculatorRepo.calculateHealthScore(
        bloodSugar, systolicBP, diastolicBP, isSmoker, hasHeartDisease
      );
      
      String formattedBloodSugar = '$bloodSugar mg/dL';
      String bloodPressure = '$systolicBP/$diastolicBP mmHg';

      // Ambil kategori dan perhitungan lainnya
      String bloodSugarCategory = _healthCalculatorRepo.getBloodSugarCategory(bloodSugar);
      String bloodPressureCategory = _healthCalculatorRepo.getBloodPressureCategory(systolicBP, diastolicBP);
      double bloodPressureRatio = _healthCalculatorRepo.getBloodPressureRatio(systolicBP, diastolicBP);
      String heartDiseaseRisk = _healthCalculatorRepo.getHeartDiseaseRisk(bloodSugar, systolicBP, diastolicBP);
      String idealGuidelines = _healthCalculatorRepo.getIdealHealthGuidelines();

      String formattedBloodPressureRatio = bloodPressureRatio.toStringAsFixed(2);

      // Ambil userId dari Firebase Auth
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      print("User ID: $userId");

      if (userId == null) {
        emit(HealthError('No user logged in.'));
        return;
      }

      // Simpan hasil ke Firestore berdasarkan userId yang terautentikasi
      await _firestore.collection('users').doc(userId)
        .collection('health_data').doc('$timestamp').set({
            'bloodsugar' : formattedBloodSugar,
            'Bloodpressure': bloodPressure,
            'healthScore': healthScore,
            'bloodSugarCategory': bloodSugarCategory,
            'bloodPressureCategory': bloodPressureCategory,
            'bloodPressureRatio': formattedBloodPressureRatio,
            'heartDiseaseRisk': heartDiseaseRisk,
            'idealGuidelines': idealGuidelines,
            'timestamp': FieldValue.serverTimestamp(),
});

      // Emit state dengan data yang dihitung
      emit(HealthCalculated(
        healthScore,
        bloodSugarCategory,
        bloodPressureCategory,
        bloodPressureRatio,
        heartDiseaseRisk,
        idealGuidelines,
        bloodPressure,
        formattedBloodSugar,
        formattedBloodPressureRatio 
      ));
    } catch (e) {
      emit(HealthError('Error calculating health score: $e'));
    }
  }
}
