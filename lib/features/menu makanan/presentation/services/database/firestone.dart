import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoneService {
  // Simpan order ke subkoleksi 'orders' di dokumen user
  Future<void> saveOrderToUser(String userId, String receipt) async {
    try {
      // Referensi ke subkoleksi 'orders' dalam dokumen user
      final CollectionReference userOrders = FirebaseFirestore.instance
          .collection('users') // Koleksi 'users'
          .doc(userId) // Dokumen user berdasarkan userId
          .collection('orders'); // Subkoleksi 'orders'

      // Tambahkan order ke subkoleksi
      await userOrders.add({
        'date': DateTime.now(),
        'order': receipt,
      });

      print('Order berhasil disimpan untuk user: $userId');
    } catch (e) {
      print('Error menyimpan order untuk user $userId: $e');
    }
  }
}
