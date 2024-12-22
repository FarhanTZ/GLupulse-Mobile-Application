import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/doctor.dart';
import '../../models/list_doctor.dart';
import 'package:finpro/features/rekomendasi/presentation/pages/dokter_detail_pages.dart';

class RekomendasiPage extends StatelessWidget {
  const RekomendasiPage({super.key});

  Future<String> fetchUserName() async {
    final userId = FirebaseAuth.instance.currentUser?.uid; // Ambil UID user saat ini
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users') // Koleksi 'users'
          .doc(userId) // Dokumen dengan ID user
          .get();
      return snapshot.data()?['name'] ?? 'Guest'; // Mengambil field 'name', default 'Guest'
    }
    return 'Guest'; // Jika user belum login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: fetchUserName(), // Fungsi untuk mengambil nama
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                'Hello...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            } else if (snapshot.hasError) {
              return const Text(
                'Hello, Guest',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }
            return Text(
              'Hello, ${snapshot.data}', // Tampilkan nama yang diambil
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCard(
                    icon: Icons.food_bank,
                    label: 'Rekomendasi Makanan',
                    color: Colors.green,
                  ),
                  _buildCard(
                    icon: Icons.directions_run,
                    label: 'Rekomendasi Aktivitas',
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'What Are Your Symptoms?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSymptomList(),
            const SizedBox(height: 20),
            const Text(
              'Popular Doctors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return _buildDoctorCard(context, doctor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: color),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomCard(String symptomName, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.grey[300],
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  symptomName,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomList() {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSymptomCard('Temperature', Icons.thermostat, Colors.red),
          _buildSymptomCard('Snuffle', Icons.water_drop, Colors.blue),
          _buildSymptomCard('Cough', Icons.sick, Colors.brown),
          _buildSymptomCard('Fatigue', Icons.battery_alert, Colors.yellow),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, Doctor doctor) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailPage(doctor: doctor),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(doctor.profileImage),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    doctor.specialty,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, size: 18, color: Colors.orange),
                const SizedBox(width: 4),
                Text(
                  doctor.rating.toString(),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
