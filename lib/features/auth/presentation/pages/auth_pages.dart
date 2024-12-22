import 'package:flutter/material.dart';
import 'package:finpro/features/auth/presentation/pages/login_pages.dart';
import 'package:finpro/features/auth/presentation/pages/register_pages.dart';

import 'Introduction_Pages.dart'; // Pastikan sudah ada halaman IntroductionPage

class AuthPages extends StatefulWidget {
  const AuthPages({super.key});

  @override
  State<AuthPages> createState() => _AuthPagesState();
}

class _AuthPagesState extends State<AuthPages> {
  // Tambahkan state untuk menentukan apakah sudah melihat halaman introduction
  bool showIntroductionPage = true;
  bool showLoginPage = false;

  // Fungsi untuk mengganti halaman
  void togglePages() {
    setState(() {
      if (showIntroductionPage) {
        showIntroductionPage = false;
        showLoginPage = true;
      } else {
        showLoginPage = !showLoginPage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan halaman introduction pertama kali
    if (showIntroductionPage) {
      return IntroductionPage(
        onNext: togglePages, // Berikan fungsi togglePages untuk pindah ke login/register
      );
    }
    
    // Setelah itu tampilkan halaman login atau register
    if (showLoginPage) {
      return LoginPages(
        togglePages: togglePages,
      );
    } else {
      return RegisterPages(
        togglePages: togglePages,
      );
    }
  }
}
