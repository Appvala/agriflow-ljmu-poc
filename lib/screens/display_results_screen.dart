// lib/screens/display_results_screen.dart

import 'package:flutter/material.dart';
import '../models/recommendation_response.dart';
import '../widgets/crop_card.dart';
import '../utils/constants.dart';

class DisplayResultsScreen extends StatelessWidget {
  final RecommendationResponse response;
  const DisplayResultsScreen({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
        backgroundColor: AppColors.blueAccent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Summary section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.blueAccent.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Based on current water conditions, we recommend:',
                      style: AppTextStyles.subtitle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.blueAccent.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.water,
                            color: AppColors.blueAccent,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${response.recommendations.length} suitable crops',
                          style: AppTextStyles.body.copyWith(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Grid of crop cards
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final cropName = response.recommendations[index];
                  return CropCard(
                    cropName: cropName,
                    description: _describeCrop(cropName),
                    onTap: () {
                      // TODO: navigate to crop detail
                    },
                  );
                },
                childCount: response.recommendations.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _describeCrop(String crop) {
    switch (crop) {
      case 'Barley':
        return 'Salt-tolerant grain';
      case 'Cotton':
        return 'Fiber crop, moderate water need';
      case 'Sugar Beet':
        return 'High-sugar yield, saline resilience';
      case 'Millet':
        return 'Drought resistant cereal';
      case 'Chickpeas':
        return 'Legume, low water requirement';
      case 'Pigeon Pea':
        return 'Nitrogen-fixing legume';
      case 'Rice':
        return 'Requires abundant water';
      case 'Wheat':
        return 'Moderate water requirement';
      case 'Maize':
        return 'Versatile cereal crop';
      default:
        return '';
    }
  }
}