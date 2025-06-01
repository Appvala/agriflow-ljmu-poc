// lib/models/switch_plan.dart

class SwitchPlan {
  final String catchCrop;
  final List<String> prepSteps;
  final int timelineDays;
  final String seedRate;
  final String fertilizer;
  final String irrigation;
  final String costBenefit;

  SwitchPlan({
    required this.catchCrop,
    required this.prepSteps,
    required this.timelineDays,
    required this.seedRate,
    required this.fertilizer,
    required this.irrigation,
    required this.costBenefit,
  });
}
