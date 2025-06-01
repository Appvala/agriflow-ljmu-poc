// lib/models/recommendation_response.dart

import 'switch_plan.dart';

class RecommendationResponse {
  final List<String> recommendations;
  final SwitchPlan? switchPlan;
  RecommendationResponse({
    required this.recommendations,
    this.switchPlan,
  });
}
