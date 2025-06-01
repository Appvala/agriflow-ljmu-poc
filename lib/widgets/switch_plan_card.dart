// lib/widgets/switch_plan_card.dart

import 'package:flutter/material.dart';
import '../models/switch_plan.dart';
import '../utils/constants.dart';

class SwitchPlanCard extends StatelessWidget {
  final SwitchPlan plan;
  const SwitchPlanCard({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mid-Season Crop Switch Plan',
                style: AppTextStyles.headline.copyWith(fontSize: 18)),
            SizedBox(height: 8),
            Text('Catch-Crop: ${plan.catchCrop}',
                style: AppTextStyles.subtitle),
            SizedBox(height: 12),
            Text('Field Prep Steps:', style: AppTextStyles.subtitle),
            ...plan.prepSteps.map((s) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('• $s', style: AppTextStyles.body),
            )),
            SizedBox(height: 12),
            Text('Timeline: ${plan.timelineDays} days', style: AppTextStyles.body),
            Text('Seed Rate: ${plan.seedRate}', style: AppTextStyles.body),
            Text('Fertilizer: ${plan.fertilizer}', style: AppTextStyles.body),
            Text('Irrigation: ${plan.irrigation}', style: AppTextStyles.body),
            SizedBox(height: 12),
            Text('Cost vs. Benefit:', style: AppTextStyles.subtitle),
            Text(plan.costBenefit, style: AppTextStyles.bodyBold),
          ],
        ),
      ),
    );
  }
}
