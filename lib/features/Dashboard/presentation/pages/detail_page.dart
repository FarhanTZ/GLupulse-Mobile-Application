import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String additionalDescription;

  // Constructor untuk menerima data dari FoodDrinkCard
  const DetailPage({super.key, 
    required this.title,
    required this.description,
    required this.imagePath,
    required this.additionalDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ), // Warna app bar bisa disesuaikan
      ),
      body: SingleChildScrollView( // Membuat layout scrollable untuk mencegah overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menambahkan efek shadow dan border-radius pada gambar
              ClipRRect(
                borderRadius: BorderRadius.circular(16), // Sudut melengkung
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              // Deskripsi utama makanan/aktivitas dengan style menarik
              Text(
                description,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              // Menambahkan sedikit styling pada deskripsi tambahan
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey, // Background yang lebih lembut
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  additionalDescription,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    height: 1.6, // Mengatur tinggi baris agar lebih mudah dibaca
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
