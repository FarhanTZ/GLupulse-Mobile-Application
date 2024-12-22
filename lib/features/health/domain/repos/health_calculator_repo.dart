import 'dart:math' as math;

class HealthCalculatorRepo {
  // Kalkulasi health score dengan fungsi eksponensial
  int calculateHealthScore(int bloodSugar, int systolicBP, int diastolicBP, bool isSmoker, bool hasHeartDisease) {
    // Menghitung skor gula darah dengan penurunan non-linear
    double bloodSugarScore = calculateBloodSugarScore(bloodSugar);

    // Menghitung skor tekanan darah dengan penurunan non-linear
    double bloodPressureScore = calculateBloodPressureScore(systolicBP, diastolicBP);

    // Menghitung rata-rata kedua skor
    double healthScore = (bloodSugarScore + bloodPressureScore) / 2;

    // Menyesuaikan skor berdasarkan faktor risiko
    double smokerAdjustment = isSmoker ? 0.9 : 1.0;  // Mengurangi skor sedikit jika merokok
    double heartDiseaseAdjustment = hasHeartDisease ? 0.85 : 1.0;  // Mengurangi skor sedikit jika ada riwayat penyakit jantung

    // Total pengali faktor risiko
    double riskAdjustment = smokerAdjustment * heartDiseaseAdjustment;

    // Menyesuaikan health score dengan faktor risiko
    healthScore *= riskAdjustment;

    // Mengembalikan nilai skor kesehatan yang telah dibulatkan
    return healthScore.round();
  }

  // Fungsi untuk menghitung skor gula darah dengan ekspansi eksponensial
  double calculateBloodSugarScore(int bloodSugar) {
    if (bloodSugar < 70) {
      return 0; // Skor rendah jika gula darah terlalu rendah
    } else if (bloodSugar <= 99) {
      return 100; // Skor maksimal untuk gula darah normal
    } else {
      // Fungsi eksponensial untuk penurunan skor jika gula darah tinggi
      double k = 0.01;  // Menentukan kecepatan penurunan
      // Menggunakan rumus eksponensial, semakin tinggi gula darah, semakin rendah skor
      return (100 * math.exp(-k * (bloodSugar - 99))).clamp(0, 100); // Membatasi skor minimal 0
    }
  }

  // Fungsi untuk menghitung skor tekanan darah dengan ekspansi eksponensial
  double calculateBloodPressureScore(int systolicBP, int diastolicBP) {
    if (systolicBP < 120 && diastolicBP < 80) {
      return 100; // Skor maksimal untuk tekanan darah normal
    } else if (systolicBP >= 120 && systolicBP < 130 && diastolicBP < 80) {
      return 90; // Skor lebih rendah untuk tekanan darah prehypertension
    } else if ((systolicBP >= 130 && systolicBP < 140) || (diastolicBP >= 80 && diastolicBP < 90)) {
      return 70; // Skor lebih rendah untuk hipertensi tahap 1
    } else {
      // Fungsi eksponensial untuk penurunan skor jika hipertensi lebih tinggi
      double k = 0.01;  // Menentukan kecepatan penurunan
      // Menggunakan rumus eksponensial, semakin tinggi tekanan darah, semakin rendah skor
      return (100 * math.exp(-k * (systolicBP - 120))).clamp(0, 100); // Membatasi skor minimal 0
    }
  }

  // Kategori Gula Darah
  String getBloodSugarCategory(int bloodSugar) {
    if (bloodSugar < 70) {
      return "Hypoglycemia (Too Low)";
    } else if (bloodSugar >= 70 && bloodSugar <= 99) {
      return "Normal";
    } else if (bloodSugar >= 100 && bloodSugar <= 125) {
      return "Pre-diabetes";
    } else {
      return "Diabetes";
    }
  }

  // Kategori Tekanan Darah
  String getBloodPressureCategory(int systolicBP, int diastolicBP) {
    if (systolicBP < 120 && diastolicBP < 80) {
      return "Normal";
    } else if (systolicBP >= 120 && systolicBP <= 129 && diastolicBP < 80) {
      return "Elevated (Prehypertension)";
    } else if ((systolicBP >= 130 && systolicBP <= 139) || (diastolicBP >= 80 && diastolicBP <= 89)) {
      return "Hypertension Stage 1";
    } else {
      return "Hypertension Stage 2";
    }
  }

  // Rasio Tekanan Darah
  double getBloodPressureRatio(int systolicBP, int diastolicBP) {
    return systolicBP / diastolicBP;
  }

  // Risiko Penyakit Jantung
  String getHeartDiseaseRisk(int bloodSugar, int systolicBP, int diastolicBP) {
    if (bloodSugar > 125 && systolicBP > 140) {
      return "High Risk of Heart Disease";
    } else if (bloodSugar > 100 || systolicBP > 130) {
      return "Moderate Risk of Heart Disease";
    } else {
      return "Low Risk of Heart Disease";
    }
  }

  // Ideal Guidelines
  String getIdealHealthGuidelines() {
    return "Ideal Blood Sugar: 70-99 mg/dL\nIdeal Blood Pressure: <120/80 mmHg";
  }
}
