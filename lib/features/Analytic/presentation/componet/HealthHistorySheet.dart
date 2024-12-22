import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class HealthHistorySheet extends StatelessWidget {
  final String userId;

  const HealthHistorySheet({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1, // Tinggi awal (10% dari layar)
      minChildSize: 0.1, // Tinggi minimal
      maxChildSize: 0.8, // Tinggi maksimal (80% dari layar)
      builder: (context, scrollController) {
        return GestureDetector(
          onVerticalDragUpdate: (details) {}, // Aktifkan seluruh area untuk drag
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Handle untuk menarik ke atas
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const Text(
                  "History Kesehatan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Daftar history data kesehatan
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .collection('health_data')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text("Tidak ada history kesehatan ditemukan."));
                      }

                      final healthEntries = snapshot.data!.docs;

                      return ListView.builder(
                        controller: scrollController, // Penting untuk sinkronisasi scroll
                        itemCount: healthEntries.length,
                        itemBuilder: (context, index) {
                          final healthData = healthEntries[index].data() as Map<String, dynamic>;
                          final timestamp = (healthEntries[index]['timestamp'] as Timestamp).toDate();

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: ListTile(
                              leading: const Icon(Icons.history, color: Colors.blue),
                              title: Text("Input #${index + 1}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Health Score: ${healthData['healthScore'] ?? 'N/A'}"),
                                  Text("Gula Darah: ${healthData['bloodSugarCategory'] ?? 'N/A'}"),
                                  Text("Tanggal: ${timestamp.toLocal()}"),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
