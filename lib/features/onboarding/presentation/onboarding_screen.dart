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
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
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
    if (colorString.startsWith('#')) {
      return Color(int.parse(colorString.replaceFirst('#', '0xff')));
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
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
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        _steps[_currentPage].buttonText,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          fontSize: 16,
                        ),
                      ),
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
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            step.imagePath,
            height: size.height * 0.35,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 48),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Text(
                  step.title,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.primary.withOpacity(0.9),
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                    height: 1.2,
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  step.subtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.75),
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 0.3,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 32 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.primary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
