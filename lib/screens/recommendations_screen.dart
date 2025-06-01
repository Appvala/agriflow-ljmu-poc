// lib/screens/recommendations_screen.dart

import 'package:flutter/material.dart';
import '../widgets/crop_card.dart';
import '../utils/constants.dart';

class RecommendationsScreen extends StatefulWidget {
  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  // Dummy recommendations map
  final Map<String, List<String>> _cropRecommendations = {
    'High Salinity': ['Barley', 'Cotton', 'Sugar Beet'],
    'Low Water': ['Millet', 'Chickpeas', 'Pigeon Pea'],
    'Normal Conditions': ['Rice', 'Wheat', 'Maize'],
  };

  late String _selectedCondition;
  late List<String> _currentList;

  @override
  void initState() {
    super.initState();
    _selectedCondition = _cropRecommendations.keys.first;
    _currentList = _cropRecommendations[_selectedCondition]!;
  }

  void _onConditionChanged(String? newVal) {
    if (newVal == null) return;
    setState(() {
      _selectedCondition = newVal;
      _currentList = _cropRecommendations[newVal]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Recommendations'),
        backgroundColor: AppColors.blueAccent,
        elevation: 0,

      ),
      body: CustomScrollView(
        slivers: [
          // Filter dropdown section
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                  BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                  )],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter by Water Condition',
                      style: AppTextStyles.subtitle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue.withOpacity(0.1),
                        border: Border.all(
                          color: AppColors.blueAccent.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCondition,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down, color: AppColors.blueAccent),
                          dropdownColor: Colors.white,
                          style: AppTextStyles.body.copyWith(color: Colors.black87),
                          onChanged: _onConditionChanged,
                          items: _cropRecommendations.keys.map((cond) {
                            return DropdownMenuItem(
                              value: cond,
                              child: Text(cond),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Recommendations grid title
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Recommended Crops',
                style: AppTextStyles.headline.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Recommendations grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, idx) {
                  final cropName = _currentList[idx];
                  return CropCard(
                    cropName: cropName,
                    description: _describeCrop(cropName),
                    onTap: () => _showCropDetails(context, cropName),
                  );
                },
                childCount: _currentList.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85, // Better aspect ratio for cards
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCropDetails(BuildContext context, String cropName) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Text(
              cropName,
              style: AppTextStyles.headline.copyWith(fontSize: 22),
            ),
            SizedBox(height: 8),
            Text(
              _describeCrop(cropName),
              style: AppTextStyles.body.copyWith(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueAccent,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Close'),
            ),
          ],
        ),

    ));
  }

  String _describeCrop(String crop) {
    switch (crop) {
      case 'Barley':
        return 'Salt-tolerant grain crop that performs well in saline conditions. Requires moderate water.';
      case 'Cotton':
        return 'Fiber crop with moderate water needs. Tolerates some salinity but needs warm temperatures.';
      case 'Sugar Beet':
        return 'High-sugar yield crop with excellent saline resilience. Good for rotation systems.';
      case 'Millet':
        return 'Drought resistant cereal crop that matures quickly. Ideal for arid conditions.';
      case 'Chickpeas':
        return 'Protein-rich legume with low water requirements. Fixes nitrogen in soil.';
      case 'Pigeon Pea':
        return 'Nitrogen-fixing legume that tolerates drought. Good intercrop option.';
      case 'Rice':
        return 'Staple crop requiring abundant water. Best for flooded or irrigated fields.';
      case 'Wheat':
        return 'Versatile cereal with moderate water requirement. Many varieties available.';
      case 'Maize':
        return 'High-yield cereal crop with versatile uses. Requires good soil fertility.';
      default:
        return 'Recommended crop for current conditions.';
    }
  }
}