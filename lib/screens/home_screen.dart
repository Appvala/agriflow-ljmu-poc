import 'package:flutter/material.dart';
import '../widgets/water_card.dart';
import '../widgets/crop_card.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, String> _waterData = {
    'Salinity': 'High',
    'pH': '7.2',
    'Water Level': 'Low',
    'Temperature': '28°C',
  };

  final List<Map<String, String>> _recommendedCrops = [
    {'name': 'Millet', 'desc': 'Drought tolerant'},
    {'name': 'Chickpeas', 'desc': 'Low water need'},
    {'name': 'Pigeon Pea', 'desc': 'Resilient legume'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            backgroundColor: AppColors.blueAccent,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Agriflow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.blueAccent, AppColors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // Water Conditions Section
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Water Conditions',
                style: AppTextStyles.headline.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final entry = _waterData.entries.elementAt(index);
                  return WaterCard(
                    title: entry.key,
                    value: entry.value,
                    icon: _iconFor(entry.key),
                  );
                },
                childCount: _waterData.length,
              ),
            ),
          ),

          // Recommended Crops Section
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
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

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final crop = _recommendedCrops[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CropCard(
                      cropName: crop['name']!,
                      description: crop['desc']!,
                      onTap: () {
                        // TODO: navigate to detailed crop info
                      },
                    ),
                  );
                },
                childCount: _recommendedCrops.length,
              ),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String key) {
    switch (key) {
      case 'Salinity':
        return Icons.opacity;
      case 'pH':
        return Icons.science;
      case 'Water Level':
        return Icons.water;
      case 'Temperature':
        return Icons.thermostat;
      default:
        return Icons.device_thermostat;
    }
  }
}