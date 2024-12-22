import 'Aktivitas.dart';

class ActivityRecommendation {
  List<Activity> recommendActivities(int healthScore, String bloodSugarCategory, String bloodPressureCategory) {
    List<Activity> activities = [];

    // Rekomendasi berdasarkan skor kesehatan
    if (healthScore >= 90) {
      activities.add(Activity(
        name: "Running",
        description: "Running is ideal for individuals with high health scores. It improves cardiovascular health and endurance.",
        imageUrl: 'assets/Aktivity/Running.jpg',  // Menambahkan gambar
      ));
      activities.add(Activity(
        name: "Cycling",
        description: "Cycling is great for improving cardiovascular health and endurance.",
        imageUrl: 'assets/Aktivity/Cycling.jpg',  // Menambahkan gambar
      ));
    } else if (healthScore >= 70) {
      activities.add(Activity(
        name: "Walking",
        description: "Walking is great for maintaining fitness and mental clarity.",
        imageUrl: 'assets/Aktivity/Walking.jpg',  // Menambahkan gambar
      ));
      activities.add(Activity(
        name: "Yoga",
        description: "Yoga is great for maintaining fitness and mental clarity.",
        imageUrl: 'assets/Aktivity/Yoga.jpg',  // Menambahkan gambar
      ));
    } else {
      activities.add(Activity(
        name: "Stretching",
        description: "Light stretching helps improve flexibility and can boost your mood.",
        imageUrl: 'assets/Aktivity/Stretching.jpg',  // Menambahkan gambar
      ));
      activities.add(Activity(
        name: "Leisurely Walks",
        description: "Leisurely walks help improve flexibility and can boost your mood.",
        imageUrl: 'assets/Aktivity/Leisurely_Walks.jpg',  // Menambahkan gambar
      ));
    }

    // Rekomendasi berdasarkan kategori gula darah
    switch (bloodSugarCategory) {
      case "Hypoglycemia (Too Low)":
        activities.add(Activity(
          name: "Rest",
          description: "When your blood sugar is too low, it is important to rest and have a light snack to bring levels back to normal.",
          imageUrl: 'assets/Aktivity/Rest.jpg',  // Menambahkan gambar
        ));
        activities.add(Activity(
          name: "Snack",
          description: "Have a light snack to bring your blood sugar back to normal levels.",
          imageUrl: 'assets/Aktivity/Snack.jpg',  // Menambahkan gambar
        ));
        break;
      case "Normal":
        activities.add(Activity(
          name: "Balanced Routine",
          description: "A balanced exercise routine helps maintain your blood sugar level in the normal range. Regular movement is key.",
          imageUrl: 'assets/Aktivity/Balanced_Routine.jpg',  // Menambahkan gambar
        ));
        break;
      case "Pre-diabetes":
        activities.add(Activity(
          name: "Daily Exercise",
          description: "Engaging in regular physical activity helps prevent the onset of type 2 diabetes and improves insulin sensitivity.",
          imageUrl: 'assets/Aktivity/Daily_Exercise.jpg',  // Menambahkan gambar
        ));
        break;
      case "Diabetes":
        activities.add(Activity(
          name: "Moderate Activities",
          description: "Moderate activities like walking or swimming are recommended to help manage blood sugar levels and avoid complications.",
          imageUrl: 'assets/Aktivity/Moderate_Activities.jpg',  // Menambahkan gambar
        ));
        break;
    }

    // Rekomendasi berdasarkan kategori tekanan darah
    switch (bloodPressureCategory) {
      case "Normal":
        activities.add(Activity(
          name: "Regular Exercise",
          description: "Consistent, moderate exercise is great for maintaining healthy blood pressure levels.",
          imageUrl: 'assets/Aktivity/Regular_Exercise.jpg',  // Menambahkan gambar
        ));
        break;
      case "Elevated (Prehypertension)":
        activities.add(Activity(
          name: "Cardio",
          description: "Cardio exercises, like running or cycling, help reduce elevated blood pressure and improve heart health.",
          imageUrl: 'assets/Aktivity/Cardio.jpg',  // Menambahkan gambar
        ));
        break;
      case "Hypertension Stage 1":
        activities.add(Activity(
          name: "Doctor Consultation",
          description: "It's crucial to consult with your healthcare provider to manage stage 1 hypertension through medication or lifestyle changes.",
          imageUrl: 'assets/Aktivity/Doctor_Consultation.jpg',  // Menambahkan gambar
        ));
        break;
      case "Hypertension Stage 2":
        activities.add(Activity(
          name: "Yoga",
          description: "Yoga helps reduce stress and improve circulation, beneficial for managing hypertension.",
          imageUrl: 'assets/Aktivity/Yoga.jpg',  // Menambahkan gambar
        ));
        activities.add(Activity(
          name: "Tai Chi",
          description: "Tai Chi helps reduce stress and improve circulation, beneficial for managing hypertension.",
          imageUrl: 'assets/Aktivity/Tai_Chi.jpg',  // Menambahkan gambar
        ));
        break;
    }

    return activities;
  }
}
