import 'package:flutter/material.dart';
import 'package:onboardingapptask/features/onboarding/controller/onboarding_controller.dart';
import 'onboarding_screen_1.dart';
import 'onboarding_screen_2.dart';
import 'onboarding_screen_3.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  late OnboardingController _controller;

  final List<Widget> _pages = const [
    OnboardingScreen1(),
    OnboardingScreen2(),
    OnboardingScreen3(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = OnboardingController(
      context: context,
      totalPages: _pages.length,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 26, 34),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller.pageController,
              onPageChanged: (index) {
                _controller.onPageChanged(index, () => setState(() {}));
              },
              children: _pages,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _controller.currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _controller.currentPage == index
                      ? const Color.fromARGB(255, 136, 54, 243)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 65),
        child: ElevatedButton(
          onPressed: () => _controller.nextPage(() => setState(() {})),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 136, 54, 243),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
