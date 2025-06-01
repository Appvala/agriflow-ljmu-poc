// lib/screens/submission_screen.dart

import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../models/recommendation_response.dart';
import 'display_results_screen.dart';
import '../utils/constants.dart';

class SubmissionScreen extends StatefulWidget {
  @override
  _SubmissionScreenState createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends State<SubmissionScreen> {
  final DataService _service = DataService();
  final _formKey = GlobalKey<FormState>();

  // Dropdown options
  final List<String> _levels = ['Low', 'Normal', 'High'];
  String _salinity = 'Normal';
  String _pH = 'Normal';
  String _waterLevel = 'Normal';
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final RecommendationResponse resp = await _service.fetchRecommendations(
        salinity: _salinity,
        pH: _pH,
        waterLevel: _waterLevel,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DisplayResultsScreen(response: resp),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get recommendations. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required ValueChanged<String?> onChanged,
    required IconData icon,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.subtitle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
              boxShadow: [
              BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
              )],
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.blueAccent),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value,
                      isExpanded: true,
                      hint: Text(hintText),
                      style: AppTextStyles.body,
                      items: _levels.map((lvl) {
                        return DropdownMenuItem(
                          value: lvl,
                          child: Text(lvl),
                        );
                      }).toList(),
                      onChanged: onChanged,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Conditions'),
        backgroundColor: AppColors.blueAccent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your water parameters',
                style: AppTextStyles.headline.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 8),
              Text(
                'Get crop recommendations based on your water conditions',
                style: AppTextStyles.body.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),

              // Input Fields
              _buildDropdownField(
                label: 'Water Salinity',
                value: _salinity,
                onChanged: (val) => setState(() => _salinity = val!),
                icon: Icons.opacity,
                hintText: 'Select salinity level',
              ),

              _buildDropdownField(
                label: 'pH Level',
                value: _pH,
                onChanged: (val) => setState(() => _pH = val!),
                icon: Icons.science,
                hintText: 'Select pH level',
              ),

              _buildDropdownField(
                label: 'Water Availability',
                value: _waterLevel,
                onChanged: (val) => setState(() => _waterLevel = val!),
                icon: Icons.water,
                hintText: 'Select water level',
              ),

              const SizedBox(height: 40),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: _loading ? null : _submit,
                  child: _loading
                      ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  )
                      : Text(
                    'Get Recommendations',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}