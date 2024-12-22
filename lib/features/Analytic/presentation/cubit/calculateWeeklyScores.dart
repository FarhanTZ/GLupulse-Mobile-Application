List<double> calculateWeeklyScores(List<Map<String, dynamic>> scores) {
  List<double> weeklyScores = List.filled(7, 0.0); // Inisialisasi nilai default
  List<int> count = List.filled(7, 0); // Untuk menghitung jumlah nilai per hari

  // Rentang tanggal minggu ini
  final now = DateTime.now();
  final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));

  for (var scoreData in scores) {
    final timestamp = scoreData['timestamp'] as DateTime;
    final score = scoreData['healthScore'] as double;

    // Hanya data dalam rentang minggu ini
    if (timestamp.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        timestamp.isBefore(endOfWeek.add(const Duration(days: 1)))) {
      int dayIndex = timestamp.weekday - 1; // Indeks: 0 (Senin) - 6 (Minggu)
      weeklyScores[dayIndex] += score;
      count[dayIndex]++;
    }
  }

  // Rata-rata jika ada data pada hari tersebut
  for (int i = 0; i < 7; i++) {
    if (count[i] > 0) {
      weeklyScores[i] /= count[i];
    }
  }

  return weeklyScores;
}
