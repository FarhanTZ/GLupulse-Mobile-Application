import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  String getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('EEE, dd MMM yyyy').format(now);
  }

  Future<String> fetchUserName() async {
    final userId = FirebaseAuth.instance.currentUser?.uid; // Ambil UID user
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users') // Koleksi 'users'
          .doc(userId) // Dokumen dengan ID user
          .get();
      return snapshot.data()?['name'] ?? 'Guest'; // Ambil field 'name', default 'Guest'
    }
    return 'Guest'; // Jika user belum login
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1D2B53),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        getCurrentDate(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white24,
                        radius: 20,
                        child: Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: const Text(
                            '7',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gunakan FutureBuilder untuk menampilkan nama dari Firestore
                        FutureBuilder<String>(
                          future: fetchUserName(), // Ambil nama dari Firestore
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text(
                                'Hi, Guest! 👋',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Text(
                                'Hi, Guest! 👋',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return Text(
                              'Hi, ${snapshot.data}! 👋',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userId)
                                  .collection('health_data')
                                  .orderBy('timestamp', descending: true)
                                  .limit(1)
                                  .snapshots()
                                  .map((event) => event.docs.first),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }

                                if (!snapshot.hasData || snapshot.data == null) {
                                  return const Text(
                                    "0%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }

                                final latestHealthData = snapshot.data!.data() as Map<String, dynamic>;
                                final healthScore = (latestHealthData['healthScore'] ?? 0).toDouble();

                                return Text(
                                  "${healthScore.toInt()}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.health_and_safety,
                              color: Colors.white70,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Pro Member",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.white70,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search asklepios...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
