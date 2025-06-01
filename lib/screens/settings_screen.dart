// lib/screens/settings_screen.dart

import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'English';
  bool _alertsEnabled = true;
  bool _darkMode = false;
  bool _analyticsEnabled = true;

  final List<String> _languages = [
    'English',
    'Hindi',
    'Spanish',
    'French',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppColors.blueAccent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Profile Section
          _buildSectionHeader('Account Settings'),
          _buildSettingCard(
            child: ListTile(
              leading: Icon(Icons.person, color: AppColors.blueAccent),
              title: Text('Edit Profile'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, '/edit_profile'),
            ),
          ),

          // App Preferences Section
          _buildSectionHeader('App Preferences'),
          _buildSettingCard(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.language, color: AppColors.blueAccent),
                      SizedBox(width: 24),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedLanguage,
                            isExpanded: true,
                            style: AppTextStyles.body,
                            onChanged: (val) {
                              setState(() => _selectedLanguage = val!);
                            },
                            items: _languages.map((lang) {
                              return DropdownMenuItem(
                                value: lang,
                                child: Text(lang),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1),
                SwitchListTile(
                  title: Text('Dark Mode'),
                  secondary: Icon(Icons.dark_mode, color: AppColors.blueAccent),
                  value: _darkMode,
                  activeColor: AppColors.blueAccent,
                  onChanged: (val) => setState(() => _darkMode = val),
                ),
              ],
            ),
          ),

          // Notifications Section
          _buildSectionHeader('Notifications'),
          _buildSettingCard(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Alerts'),
                  subtitle: Text('Water risk notifications'),
                  secondary: Icon(Icons.notifications, color: AppColors.blueAccent),
                  value: _alertsEnabled,
                  activeColor: AppColors.blueAccent,
                  onChanged: (val) => setState(() => _alertsEnabled = val),
                ),
                Divider(height: 1),
                SwitchListTile(
                  title: Text('Recommendations'),
                  subtitle: Text('Crop suggestions'),
                  secondary: Icon(Icons.grass, color: AppColors.blueAccent),
                  value: true,
                  activeColor: AppColors.blueAccent,
                  onChanged: null, // Disabled for demo
                ),
              ],
            ),
          ),

          // Privacy Section
          _buildSectionHeader('Privacy'),
          _buildSettingCard(
            child: SwitchListTile(
              title: Text('Analytics'),
              subtitle: Text('Help improve AgriFlow'),
              secondary: Icon(Icons.analytics, color: AppColors.blueAccent),
              value: _analyticsEnabled,
              activeColor: AppColors.blueAccent,
              onChanged: (val) => setState(() => _analyticsEnabled = val),
            ),
          ),
          SizedBox(height: 8),
          _buildSettingCard(
            child: ListTile(
              leading: Icon(Icons.privacy_tip, color: AppColors.blueAccent),
              title: Text('Privacy Policy'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => _showComingSoon(context),
            ),
          ),

          // App Info Section
          _buildSectionHeader('About'),
          _buildSettingCard(
            child: ListTile(
              leading: Icon(Icons.info, color: AppColors.blueAccent),
              title: Text('Version'),
              trailing: Text('1.0.0', style: TextStyle(color: Colors.grey)),
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: TextButton(
              child: Text('Sign Out', style: TextStyle(color: Colors.red)),
              onPressed: () => _showLogoutDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 24, 8, 8),
      child: Text(
        title,
        style: AppTextStyles.subtitle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildSettingCard({required Widget child}) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Sign Out', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement sign out logic
            },
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This feature is coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}