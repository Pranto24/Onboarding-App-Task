import 'package:flutter/material.dart';
import 'package:onboardingapptask/features/onboarding/model/onboarding_model.dart';
import 'package:onboardingapptask/features/onboarding/widgets/onboarding_screen_widget.dart';
import 'onboarding_screen_3.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingData = OnboardingModel(
      imagePath: 'assets/morninggif2.gif',
      title: 'Effortless & Automatic',
      description:
          'No need to set alarms manually. Wakey calculates the sunset time for your location and alerts you on time.',
    );

    return OnboardingScreenWidget(
      model: onboardingData,
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen3()),
        );
      },
    );
  }
}