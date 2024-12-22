import 'package:finpro/features/menu%20makanan/presentation/Components/my_receipt.dart';
import 'package:finpro/features/menu%20makanan/presentation/models/restaurant.dart';
import 'package:finpro/features/menu%20makanan/presentation/services/database/firestone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Tambahkan FirebaseAuth

class DeliveryProgresPages extends StatefulWidget {
  const DeliveryProgresPages({super.key});

  @override
  State<DeliveryProgresPages> createState() => _DeliveryProgresPagesState();
}

class _DeliveryProgresPagesState extends State<DeliveryProgresPages> {
  // Instance Firestore Service
  final FirestoneService db = FirestoneService();

  // Flag untuk mencegah pemanggilan berulang
  bool _orderSaved = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_orderSaved) {
      _orderSaved = true; // Tandai sudah diproses

      // Ambil userId dari FirebaseAuth
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        print('Error: Pengguna belum login');
        return;
      }

      // Ambil receipt dari state Restaurant
      String receipt = context.read<Restaurant>().displayCartReceipt();

      // Simpan order ke Firestore
      db.saveOrderToUser(userId, receipt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: const Column(
        children: [
          MyReceipt(),
        ],
      ),
    );
  }

  // Custom Bottom Nav Bar - Message / Call delivery driver
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          // Profile pic of driver
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ),

          const SizedBox(width: 10),
          // Driver detail
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mitch Koko",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                "Driver",
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            children: [
              // Message button
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(width: 10),
              // Call button
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.call),
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
