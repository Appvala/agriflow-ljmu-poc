import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CropCard extends StatelessWidget {
  final String cropName;
  final String description;
  final VoidCallback? onTap;

  const CropCard({
    Key? key,
    required this.cropName,
    this.description = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.greenLight,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greenDark, width: 1.2),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
               Icon(Icons.grass, color: AppColors.greenDark),

              const SizedBox(width: 16),
              Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    cropName,
                    style: AppTextStyles.headline,
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(description, style: AppTextStyles.body, textAlign: TextAlign.center,),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Icon(Icons.arrow_downward, color: AppColors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
