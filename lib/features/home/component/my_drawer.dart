import 'package:flutter/material.dart'; // Import InputHealthPage
import '../../health/presentation/pages/health_input_page.dart';
import '../../menu makanan/presentation/pages/menu_makanan_pages.dart';
// Import the MenuMakananPages
import 'my_drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(""),
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey),
            ),
          ),

          // Menu item lainnya
          MyDrawerTile(
            icon: Icons.home,
            title: "Home",
            onTap: () {
              Navigator.pop(context);  // Close drawer
            },
          ),
          
          // Menambahkan menu untuk 'Input Health' di Drawer
          MyDrawerTile(
            icon: Icons.health_and_safety,
            title: "Input Health",
            onTap: () {
              Navigator.pop(context);  // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HealthInputPage()),  // Arahkan ke halaman InputHealthPage
              );
            },
          ),

          // Menambahkan menu untuk 'Menu Makanan' di Drawer
          MyDrawerTile(
            icon: Icons.fastfood,
            title: "Menu Makanan",
            onTap: () {
              Navigator.pop(context);  // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuMakananPage()),  // Arahkan ke halaman MenuMakananPage
              );
            },
          ),

          // Menambahkan menu untuk 'Settings' di Drawer, ditempatkan paling bawah
          MyDrawerTile(
            icon: Icons.settings,
            title: "Settings",
            onTap: () {
              Navigator.pop(context);  // Close drawer
            },
          ),
        ],
      ),
    );
  }
}
