// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:time_logger/widgets/square_icon_button.dart';
import 'background_widget.dart';
import 'time_in_page.dart';
import 'timesheet_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const HomePage({required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Julie's Time Logger",
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
      body: BackgroundWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SquareIconButton(
                  text: "Log Time",
                  icon: Icons.punch_clock,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimeInPage()),
                    );
                  },
                ),

                SizedBox(width: 10.0), // Add space between buttons
                SquareIconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimesheetPage()),
                    );
                  },
                  text: "Timesheet",
                  icon: Icons.ballot,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareIconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SettingsPage(onThemeChanged: onThemeChanged)),
                    );
                  },
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
