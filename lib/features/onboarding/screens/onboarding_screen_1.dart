import 'package:flutter/material.dart';
import 'package:onboardingapptask/features/onboarding/model/onboarding_model.dart';
import 'package:onboardingapptask/features/onboarding/widgets/onboarding_screen_widget.dart';
import 'onboarding_screen_2.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingData = OnboardingModel(
      imagePath: 'assets/morninggif1.gif',
      title: 'Sync with Nature’s Rhythm',
      description:
          'Experience a peaceful transition into the evening with an alarm that aligns with the sunset."\nYour perfect reminder, always 15 minutes before sundown.',
    );

    return OnboardingScreenWidget(
      model: onboardingData,
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen2()),
        );
      },
    );
  }
}