import 'package:expenses_app/providers/local_notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/pages/categories_details.dart';
import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/providers/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:expenses_app/pages/home_page.dart';
import 'package:expenses_app/pages/expenses_details.dart';
import 'package:expenses_app/pages/add_entries.dart';
import 'package:expenses_app/pages/add_expenses.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';
 
void main() async { 

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPrefs();
  await prefs.initPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ExpensesProvider()),
        ChangeNotifierProvider(create: (_) => LocalNotificationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs.darkMode))
      ],
      child: MyApp(),
    )
    
  );
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(
      builder: (context, value, child){
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('es')
        ],
        title: 'Expenses_app',
        theme: value.getTheme(),
        initialRoute: 'home',
        routes: {
          'home'               : (_) => HomePage(),
          'add_entries'        : (_) => AddEntries(),
          'add_expenses'       : (_) => AddExpenses(),
          'expenses_details'   : (_) => ExpensesDetails(),
          'categories_details' : (_) => CategoriesDetails(),
        },
      );
      }, 
    );
  }
}