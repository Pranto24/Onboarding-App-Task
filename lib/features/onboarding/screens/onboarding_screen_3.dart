import 'package:flutter/material.dart';
import 'package:onboardingapptask/features/onboarding/model/onboarding_model.dart';
import 'package:onboardingapptask/features/onboarding/widgets/onboarding_screen_widget.dart';
import 'package:onboardingapptask/welcome_page.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingData = OnboardingModel(
      imagePath: 'assets/morninggif3.gif',
      title: 'Relax & Unwind',
      description:
          'Hope to take the courage to pursue your dreams.',
    );

    return OnboardingScreenWidget(
      model: onboardingData,
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
        );
      },
    );
  }
}