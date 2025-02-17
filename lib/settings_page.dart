// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const SettingsPage({required this.onThemeChanged}) : super();

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  TextEditingController _hourlyRateController = TextEditingController();
  TextEditingController _nightDifferentialRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
      _hourlyRateController.text = (prefs.getDouble('hourlyRate') ?? 65.00).toString();
      _nightDifferentialRateController.text = ((prefs.getDouble('nightDifferentialRate') ?? 0.10) * 100).toString();
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    await prefs.setDouble('hourlyRate', double.parse(_hourlyRateController.text));
    await prefs.setDouble('nightDifferentialRate', double.parse(_nightDifferentialRateController.text) / 100);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/time_logger_logo.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withAlpha((0.2 * 255).toInt()), // Adjust the opacity here
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24.0, // Make the title bigger
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
            centerTitle: true, // Center the title
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Dark Mode'),
                  value: _isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                    widget.onThemeChanged(value);
                  },
                ),
                TextFormField(
                  controller: _hourlyRateController,
                  decoration: InputDecoration(
                    labelText: 'Basic Hourly Rate',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _nightDifferentialRateController,
                  decoration: InputDecoration(
                    labelText: 'Night Differential Rate (%)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.0), // Add space before the button
                ElevatedButton(
                  onPressed: () {
                    _saveSettings();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Settings have been saved')),
                    );
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
