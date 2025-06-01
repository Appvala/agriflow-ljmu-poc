// lib/main.dart

import 'package:flutter/material.dart';
import 'models/recommendation_response.dart';
import 'screens/dashboard_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/recommendations_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/submission_screen.dart';
import 'screens/display_results_screen.dart';
import 'screens/edit_profile_screen.dart';    // ← add import
import 'utils/constants.dart';

void main() {
  runApp(AgriFlowApp());
}

class AgriFlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriFlow Prototype',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.blueAccent,
          elevation: 2,
        ),
      ),
      initialRoute: '/dashboard',
      routes: {
        '/submission':       (_) => SubmissionScreen(),
        '/dashboard':        (_) => DashboardScreen(),
        '/alerts':           (_) => AlertsScreen(),
        '/recommendations':  (_) => RecommendationsScreen(),
        '/settings':         (_) => SettingsScreen(),
        '/edit_profile':     (_) => EditProfileScreen(),  // ← new route
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/results') {
          final args = settings.arguments as RecommendationResponse;
          return MaterialPageRoute(
            builder: (_) => DisplayResultsScreen(response: args),
          );
        }
        return null;
      },
    );
  }
}
