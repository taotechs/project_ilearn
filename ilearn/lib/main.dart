// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/preferences_screen.dart';
import 'screens/detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> userPreferences = {
    'interests': [
      'Flutter',
      'Machine Learning',
      'Artificial Intelligence',
      'Mobile Development',
    ],
  };

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tech Learning Roadmap',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OnboardingScreen(),
      routes: {
        PreferencesScreen.routeName: (context) => const PreferencesScreen(),
        DetailScreen.routeName: (context) => const DetailScreen(),
        HomeScreen.routeName: (context) =>
            HomeScreen(preferences: userPreferences),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/main';

  const OnboardingScreen({super.key});
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome to Tech Learning Roadmap',
      'description':
          'Discover a new way to streamline your journey in learning technology. '
              'Our app provides carefully curated resources, so you can focus on acquiring '
              'the skills that matter most in today’s tech landscape.',
    },
    {
      'title': 'Personalized Roadmaps',
      'description':
          'We understand that everyone’s learning path is unique. That’s why our app '
              'tailors recommendations based on your specific interests and goals, guiding '
              'you through a structured, efficient learning process.',
    },
    {
      'title': 'Start Your Journey Now',
      'description':
          'Embark on your tech journey with confidence. With our curated resources and '
              'personalized roadmaps, you’re just a few clicks away from mastering the tech '
              'skills that will shape your future.',
    },
  ];

  void _onNextPressed() {
    if (currentIndex == onboardingData.length - 1) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _onSkipPressed() {
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        onboardingData[index]['title']!,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24.0),
                      Text(
                        onboardingData[index]['description']!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _onSkipPressed,
                  child: const Text('SKIP'),
                ),
                ElevatedButton(
                  onPressed: _onNextPressed,
                  child: Text(currentIndex == onboardingData.length - 1
                      ? 'GET STARTED'
                      : 'NEXT'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
