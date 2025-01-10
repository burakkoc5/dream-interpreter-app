import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:dream/features/onboarding/models/onboarding_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingStep> _steps = [
    const OnboardingStep(
      title: 'Welcome to Dream Interpreter!',
      subtitle: 'Understand and explore the meaning of your dreams.',
      imagePath: 'assets/images/onboarding/onboarding_1.png',
      buttonText: 'Next',
      backgroundColor: '#F9D8FF',
    ),
    const OnboardingStep(
      title: 'Record your dreams with ease',
      subtitle: 'Capture your dreams and let us help you interpret them.',
      imagePath: 'assets/images/onboarding/onboarding_2.png',
      buttonText: 'Next',
      backgroundColor: '#CDCEF8',
    ),
    const OnboardingStep(
      title: 'Get AI-powered interpretations',
      subtitle: 'Let our AI offer meaningful insights into your dreams.',
      imagePath: 'assets/images/onboarding/onboarding_3.png',
      buttonText: 'Next',
      backgroundColor: '#F8DEFF',
    ),
    const OnboardingStep(
      title: 'Review your past dreams and insights',
      subtitle: 'Track your dream journey and patterns over time.',
      imagePath: 'assets/images/onboarding/onboarding_4.png',
      buttonText: 'Get Started',
      backgroundColor: '#CDDCFF',
    ),
  ];

  void _onNextPressed() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    await context.read<OnboardingCubit>().completeOnboarding();
    if (!mounted) return;
    context.go(AppRoute.login);
  }

  Color _colorFromString(String colorString) {
    // If the string starts with '#' (hex format), convert it to Color
    if (colorString.startsWith('#')) {
      return Color(int.parse(colorString.replaceFirst('#', '0xff')));
    } else {
      // If not a valid hex color, return a default color (e.g., grey)
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: _colorFromString(_steps[_currentPage].backgroundColor),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _steps.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final step = _steps[index];
                    return _OnboardingPage(step: step);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        _steps.length,
                        (index) => _PageIndicator(
                          isActive: index == _currentPage,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onNextPressed,
                      child: Text(_steps[_currentPage].buttonText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingStep step;

  const _OnboardingPage({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            step.imagePath,
            height: 350,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 48),
          Text(
            step.title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            step.subtitle,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;

  const _PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
