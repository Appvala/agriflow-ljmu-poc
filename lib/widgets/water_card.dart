import 'package:flutter/material.dart';
import '../utils/constants.dart';

class WaterCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  const WaterCard({
    Key? key,
    required this.title,
    required this.value,
    this.icon = Icons.water_drop,
  }) : super(key: key);

  @override
  _WaterCardState createState() => _WaterCardState();
}

class _WaterCardState extends State<WaterCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _elevationAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _elevationAnim = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _elevationAnim,
      builder: (context, _) => Card(
        elevation: _elevationAnim.value,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 36, color: AppColors.blueAccent),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: 4),
              Text(
                widget.value,
                style: AppTextStyles.headline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
