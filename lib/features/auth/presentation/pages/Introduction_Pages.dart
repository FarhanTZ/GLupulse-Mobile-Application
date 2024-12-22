import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroductionPage extends StatefulWidget {
  final VoidCallback onNext;

  const IntroductionPage({super.key, required this.onNext});

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0; // Track current page index

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt() ?? 0; // Update current page index
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildPage(
                  context,
                  'Track your daily health\nintake with us!',
                  'Monitor your blood sugar and pressure,\none step closer to better health!',
                  'assets/animation/Splassreen1.json',
                  false,
                ),
                _buildPage(
                  context,
                  'Smart Reminders\nTailored to You',
                  'Quick and easy to set your health goals & monitor\nyour blood sugar and pressure progress daily.',
                  'assets/animation/Splassreen2.json',
                  false,
                ),
                _buildPage(
                  context,
                  'Get Started!',
                  'Let’s start your journey with us.',
                  'assets/animation/Splassreen3.json',
                  true, // Tombol "Next" muncul di slide terakhir
                ),
              ],
            ),
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, String title, String description, String animationPath, bool showNextButton) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              animationPath,
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            if (showNextButton)
              ElevatedButton(
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Next'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: _currentPage == index ? Theme.of(context).colorScheme.primary : Colors.grey,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
