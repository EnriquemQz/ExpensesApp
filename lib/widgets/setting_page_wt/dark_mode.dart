import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkMode extends StatefulWidget {
  DarkMode({Key key}) : super(key: key);

  @override
  _DarkModeState createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  bool _darkMode;
  final prefs = new UserPrefs();

  @override
  void initState() {
    super.initState();
    _darkMode = prefs.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _darkMode,
      title: Text(
        'Modo Oscuro',
        style: TextStyle(
          color: (_darkMode) ? Colors.white : Colors.black
        ),
      ),
      subtitle: Text('El modo oscuro ayuda ahorrar batería'),
      onChanged: (value){
        setState(() {
          _darkMode = value;
          prefs.darkMode = value;
          Provider.of<ThemeProvider>(context, listen: false).swapTheme();
        });
      },
    );
  }
}