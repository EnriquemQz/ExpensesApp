
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme;

  ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey[900],
    // accentColor: Colors.green,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0.0,
      backgroundColor: Colors.green,
      foregroundColor: Colors.white
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.green
    ),
    appBarTheme: AppBarTheme(
      color: Colors.grey[900]
    ),
    // dividerColor: Colors.white
  );

  ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryTextTheme: Typography.material2018()
      .black.merge(Typography.englishLike2018),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0.0,
      backgroundColor: Colors.green,
      foregroundColor: Colors.white
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.black
      ), 
    ),
    // dividerColor: Colors.black
  );

  ThemeProvider(bool isDark){
    _selectedTheme = (isDark) ? dark : light;
  }

  Future<void> swapTheme() async {
    if (_selectedTheme == dark){
      _selectedTheme = light;
    } else {
      _selectedTheme = dark;
    }
    notifyListeners();
  }

  ThemeData getTheme() => _selectedTheme;
}