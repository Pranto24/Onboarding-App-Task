import 'package:flutter/material.dart';
import 'package:onboardingapptask/welcome_page.dart';

class OnboardingController {
  final PageController pageController = PageController();
  int currentPage = 0;

  final BuildContext context;
  final int totalPages;

  OnboardingController({
    required this.context,
    required this.totalPages,
  });

  void onPageChanged(int index, VoidCallback refresh) {
    currentPage = index;
    refresh(); // setState callback
  }

  void nextPage(VoidCallback refresh) {
    if (currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToWelcomePage();
    }
  }

  void _goToWelcomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  void dispose() {
    pageController.dispose();
  }
}
