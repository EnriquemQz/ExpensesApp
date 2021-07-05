import 'package:expenses_app/pages/add_entries.dart';
import 'package:expenses_app/pages/add_expenses.dart';
import 'package:expenses_app/pages/home_page.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ExpensesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('es')
        ],
        title: 'Expenses_app',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.grey[900],
          accentColor: Colors.green,
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
          )
        ),
        initialRoute: 'home',
        routes: {
          'home'        : (_) => HomePage(),
          'add_entries' : (_) => AddEntries(),
          'add_expenses': (_) => AddExpenses(),
        },
      ),
    );
  }
}