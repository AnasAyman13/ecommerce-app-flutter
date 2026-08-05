import 'package:flutter/material.dart';

import '../../models/onboarding_page_model.dart';

class OnboardingPageCard extends StatelessWidget {
  final OnboardingPageModel page;

  const OnboardingPageCard({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(page.title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        Text(page.description, textAlign: TextAlign.center),
      ],
    );
  }
}
