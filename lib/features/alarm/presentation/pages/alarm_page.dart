import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class SimpleCalendarPage extends StatefulWidget {
  const SimpleCalendarPage({super.key});

  @override
  _SimpleCalendarPageState createState() => _SimpleCalendarPageState();
}

class _SimpleCalendarPageState extends State<SimpleCalendarPage> {
  DateTime _selectedDate = DateTime.now();
  late DateTime _firstDayOfMonth;
  late DateTime _lastDayOfMonth;

  @override
  void initState() {
    super.initState();
    _updateMonthRange();
  }

  // Menghitung hari pertama dan terakhir dalam bulan yang dipilih
  void _updateMonthRange() {
    _firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    _lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
  }

  // Fungsi untuk menghasilkan tanggal dalam bulan yang dipilih
  List<Widget> _buildCalendarDays() {
    List<Widget> days = [];
    DateTime firstDayOfMonth = _firstDayOfMonth;

    // Menambahkan blank space untuk hari pertama bulan (misalnya, jika bulan dimulai dari hari Rabu)
    int firstDayOffset = firstDayOfMonth.weekday;  // 1=Senin, 7=Minggu
    for (int i = 0; i < firstDayOffset - 1; i++) {
      days.add(Container()); // Menambahkan kotak kosong untuk menyesuaikan offset
    }

    // Menambahkan tanggal dalam bulan
    for (int i = 0; i < _lastDayOfMonth.day; i++) {
      DateTime date = DateTime(_selectedDate.year, _selectedDate.month, i + 1);
      days.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = date; // Menyimpan tanggal yang dipilih
            });
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _selectedDate.day == date.day
                  ? Colors.blueAccent
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: _selectedDate.day == date.day ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalender Sederhana")),
      body: Column(
        children: [
          // Menampilkan bulan dan tahun
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              DateFormat('MMMM yyyy').format(_selectedDate),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Grid untuk kalender
          Expanded(
            child: GridView.count(
              crossAxisCount: 7, // 7 kolom untuk hari Minggu sampai Sabtu
              children: _buildCalendarDays(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fungsi untuk berpindah ke bulan sebelumnya
          setState(() {
            _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
            _updateMonthRange();
          });
        },
        tooltip: 'Bulan Sebelumnya',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
