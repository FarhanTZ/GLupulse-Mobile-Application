import 'package:finpro/features/home/component/my_bottom_navbar.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finpro/features/auth/presentation/cubits/auth.cubit.dart';
import '../../../Analytic/presentation/pages/analytic_page.dart';
import '../../../Dashboard/presentation/pages/Dashboard_pages.dart';
import '../../../alarm/presentation/pages/alarm_page.dart';
import '../../../rekomendasi/presentation/pages/rekomendasi_page.dart';
import '../../component/my_drawer.dart';  // Import MyDrawer // Import RekomendasiPage
import 'profile_page.dart';  // Import ProfilePage

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 2; // Menentukan tab yang aktif

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Daftar halaman untuk BottomNavigationBar
  final List<Widget> _pages = [
    const HealthAnalyticsPage(),
    const SimpleCalendarPage(),
    const DashboardPage(),
    const RekomendasiPage(),  // Pass the name here
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  // Menambahkan key pada Scaffold
      appBar: AppBar(
        actions: [
          // Tombol logout
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();  // Gunakan key untuk membuka drawer
          },
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,  // Gunakan tema untuk background
      drawer: const MyDrawer(),  // Gunakan MyDrawer disini
      body: _pages[_selectedIndex],  // Tampilkan halaman sesuai dengan tab yang dipilih
      bottomNavigationBar: MyBottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
