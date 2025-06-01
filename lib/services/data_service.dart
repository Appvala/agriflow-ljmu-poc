// lib/services/data_service.dart

import 'dart:async';
import '../models/recommendation_response.dart';
import '../models/switch_plan.dart';

class DataService {
  Future<RecommendationResponse> fetchRecommendations({
    required String salinity,
    required String pH,
    required String waterLevel,
  }) async {
    await Future.delayed(Duration(seconds: 2));

    // Basic crop list as before
    List<String> crops;
    if (salinity == 'High') {
      crops = ['Barley', 'Cotton', 'Sugar Beet'];
    } else if (waterLevel == 'Low') {
      crops = ['Millet', 'Chickpeas', 'Pigeon Pea'];
    } else {
      crops = ['Rice', 'Wheat', 'Maize'];
    }

    // If severe, build a switch plan
    SwitchPlan? plan;
    if (salinity == 'High' || waterLevel == 'Low') {
      plan = SwitchPlan(
        catchCrop: salinity == 'High' ? 'Barley' : 'Millet',
        prepSteps: [
          'Uproot original seedlings or cut at ground level',
          'Lightly incorporate residues with a tine harrow',
          'Level field to avoid water pockets',
          'Broadcast seed and firm soil'
        ],
        timelineDays: 70,
        seedRate: 'Increase seed rate by 25% for uneven germination',
        fertilizer: 'Apply starter dose: 20 kg/ha N + 40 kg/ha P₂O₅',
        irrigation: 'Use one light drip irrigation 7 days after sowing',
        costBenefit: 'Seed cost ₹1,500/ha vs. expected yield ₹8,000/ha',
      );
    }

    return RecommendationResponse(
      recommendations: crops,
      switchPlan: plan,
    );
  }
}
