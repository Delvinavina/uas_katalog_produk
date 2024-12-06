import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Settings variables
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  double _fontSize = 16.0;
  String _language = 'English';

  // Language options
  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Notification Settings
          _buildSettingsSection(
            title: 'Notifications',
            children: [
              _buildSwitchListTile(
                title: 'Enable Notifications',
                subtitle: 'Receive app updates and alerts',
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ],
          ),

          // Appearance Settings
          _buildSettingsSection(
            title: 'Appearance',
            children: [
              _buildSwitchListTile(
                title: 'Dark Mode',
                subtitle: 'Switch between light and dark themes',
                value: _darkModeEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _darkModeEnabled = value;
                    // Implement theme switching logic
                  });
                },
              ),
              _buildSliderListTile(
                title: 'Font Size',
                value: _fontSize,
                min: 12.0,
                max: 24.0,
                onChanged: (double value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
            ],
          ),

          // Language Settings
          _buildSettingsSection(
            title: 'Language',
            children: [
              _buildDropdownListTile(
                title: 'App Language',
                value: _language,
                items: _languages,
                onChanged: (String? newValue) {
                  setState(() {
                    _language = newValue!;
                    // Implement language change logic
                  });
                },
              ),
            ],
          ),

          // Account Settings
          _buildSettingsSection(
            title: 'Account',
            children: [
              _buildListTile(
                title: 'Change Password',
                icon: Icons.lock,
                onTap: () {
                  // Navigate to change password screen
                },
              ),
              _buildListTile(
                title: 'Privacy Settings',
                icon: Icons.privacy_tip,
                onTap: () {
                  // Navigate to privacy settings
                },
              ),
            ],
          ),

          // About Section
          _buildSettingsSection(
            title: 'About',
            children: [
              _buildListTile(
                title: 'App Version',
                subtitle: '1.0.0',
                icon: Icons.info,
                onTap: () {
                  // Show app version details
                },
              ),
              _buildListTile(
                title: 'Terms of Service',
                icon: Icons.document_scanner,
                onTap: () {
                  // Show terms of service
                },
              ),
            ],
          ),

          // Save Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: _saveSettings,
              child: Text('Save Settings'),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          elevation: 2,
          child: Column(children: children),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    String? subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSliderListTile({
    required String title,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Slider(
        value: value,
        min: min,
        max: max,
        divisions: 6,
        label: value.round().toString(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownListTile({
    required String title,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      leading: Icon(icon),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _saveSettings() {
    // Implement save settings logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings Saved Successfully!')),
    );
  }
}
