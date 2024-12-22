import 'package:flutter/material.dart';

class AnalyticCard extends StatelessWidget {
  final String title; // Judul kartu
  final String value; // Nilai atau data yang ditampilkan
  final IconData? icon; // Ikon kartu (bisa null)
  final Color color; // Warna ikon
  final bool isLongText; // Jika teks panjang, atur overflow
  final double spacing; // Jarak antara title dan value
  final bool showIcon; // Kontrol apakah ikon akan ditampilkan
  final VoidCallback? onTap; // Fungsi yang dijalankan ketika kartu ditekan

  const AnalyticCard({
    super.key,
    required this.title,
    required this.value,
    this.icon, // Ikon bersifat opsional
    required this.color,
    this.isLongText = false,
    this.spacing = 16.0, // Default jarak antara title dan value
    this.showIcon = true, // Default: tampilkan ikon
    this.onTap, // Fungsi opsional
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Aksi ketika kartu ditekan
      borderRadius: BorderRadius.circular(10.0), // Efek klik dengan sudut melengkung
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showIcon && icon != null) // Tampilkan ikon jika showIcon true dan icon tidak null
                Icon(icon, size: 40, color: color),
              if (showIcon && icon != null)
                const SizedBox(height: 10), // Jarak antara ikon dan title
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spacing), // Jarak dinamis antara title dan value
              isLongText
                  ? Flexible(
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    )
                  : Text(
                      value,
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
