// lib/screens/alerts_screen.dart

import 'package:flutter/material.dart';
import '../widgets/alert_card.dart';
import '../utils/constants.dart';

class AlertsScreen extends StatefulWidget {
  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  // Dummy alerts data
  List<String> _alerts = [
    'Water salinity levels rising — Recommend salt-tolerant crops!',
    'Water table dropping — Switch to drought-tolerant varieties.',
    'Heavy rainfall forecast — Risk of waterlogging.',
    'Sudden pH swing detected — Check soil amendments.',
  ];

  Future<void> _refreshAlerts() async {
    // Simulate network fetch delay
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // For demo, just shuffle the list
      _alerts.shuffle();
    });
  }

  void _clearAll() {
    setState(() {
      _alerts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgriFlow Alerts'),
        backgroundColor: AppColors.blueAccent,
        elevation: 0,
        actions: [
          if (_alerts.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear_all),
              tooltip: 'Clear All Alerts',
              onPressed: _clearAll,
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshAlerts,
        child: _alerts.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_off,
                size: 64,
                color: AppColors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No active alerts',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.grey,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pull down to refresh',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.grey.withOpacity(0.7),
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemCount: _alerts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: AlertCard(
                message: _alerts[index],
                onTap: () {
                  // Optional: navigate to detail or highlight
                },
              ),
            );
          },
        ),
      ),
    );
  }
}