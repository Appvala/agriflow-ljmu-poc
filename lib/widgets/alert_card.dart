import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AlertCard extends StatefulWidget {
  final String message;
  final VoidCallback? onTap;

  const AlertCard({Key? key, required this.message, this.onTap})
      : super(key: key);

  @override
  _AlertCardState createState() => _AlertCardState();
}

class _AlertCardState extends State<AlertCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    // trigger a shake on load to draw attention
    _shakeController.forward().then((_) => _shakeController.reverse());
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) => Transform.translate(
        offset: Offset(_shakeAnimation.value * (math.sin(DateTime.now().millisecond.toDouble())), 0),
        child: child,
      ),
      child: Card(
        color: AppColors.orangeLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          onTap: widget.onTap,
          leading: Icon(Icons.warning, color: AppColors.orangeDark, size: 32),
          title: Text(widget.message, style: AppTextStyles.bodyBold),
        ),
      ),
    );
  }
}
