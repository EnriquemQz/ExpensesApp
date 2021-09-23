import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:flutter/material.dart';

class FlayerSkin extends StatelessWidget {
  final String myTitle;
  final Widget myWidget;
  const FlayerSkin(
    {
      Key key, 
      @required this.myTitle, 
      @required this.myWidget
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = new UserPrefs();
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 14.0, right: 14.0, bottom: 14.0),
      child: Column(
        children:[
          Container(
            padding: EdgeInsets.only(left: 14.0, bottom: 8.0),
            width: size.width,
            child: Text(
              myTitle,
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 1.5
              ),
            ),
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.all(16.0),
            decoration: (prefs.darkMode)
              ? DarkMode.flayer
              : LightMode.flayer,
            child: myWidget,
          )
        ]
      ),
    );
  }
}