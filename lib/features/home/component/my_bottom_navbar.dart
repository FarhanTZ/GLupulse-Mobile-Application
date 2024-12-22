import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MyBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: selectedIndex,  // Tab yang aktif
      onTap: onItemTapped,  // Fungsi saat tab dipilih
      items: const <Widget>[
        Icon(Icons.analytics, size: 30),
        Icon(Icons.alarm, size: 30),
        Icon(Icons.home, size: 30),  // Home button di tengah
        Icon(Icons.recommend, size: 30),
        Icon(Icons.account_circle, size: 30),
      ],
      color: const Color.fromARGB(255, 190, 197, 203),  // Warna background navbar
      buttonBackgroundColor: const Color.fromARGB(255, 190, 197, 203),  // Warna button (ikon tengah)
      backgroundColor: Colors.white,  // Warna background ketika tidak aktif
      animationCurve: Curves.easeInOut,  // Animasi saat berpindah tab
      animationDuration: const Duration(milliseconds: 300),  // Durasi animasi
    );
  }
}
