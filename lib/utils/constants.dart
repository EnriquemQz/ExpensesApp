import 'package:flutter/material.dart';

class DarkMode {

  static Color bsNumberColor = Colors.grey[900];

  static BoxDecoration ftBoxDecoration = BoxDecoration(
    color: Colors.grey[850],
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(50.0),
      topRight: Radius.circular(50.0)
    )
  );

  static BoxDecoration fiBoxDecoration = BoxDecoration(
    color: Colors.grey[900],
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(50.0),
      topRight: Radius.circular(50.0)
    )
  );

  static BoxDecoration btnCancel = BoxDecoration(
    border: Border.all(
      color: Colors.red
    ),
    borderRadius: BorderRadius.circular(25.0)
  );

  static BoxDecoration btnOk = BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(25.0)
  );

  static BoxDecoration bsCategory = BoxDecoration(
    border: Border.all(
      color: Colors.grey 
    ),
    borderRadius: BorderRadius.circular(20.0)
  );

  static RoundedRectangleBorder bottomSheet = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0)
    )
  );

  static BoxDecoration flayer = BoxDecoration(
    color: Colors.grey[850],
    borderRadius: BorderRadius.all(
      Radius.circular(25.0)
    )
  );

  static BoxDecoration gridBoxDecoration = BoxDecoration(
    color: Colors.grey[900],
    borderRadius: BorderRadius.all(Radius.circular(20.0))
  );
}

class LightMode {

  static Color bsNumberColor = Colors.white;

  static BoxDecoration ftBoxDecoration = BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(50.0),
      topRight: Radius.circular(50.0)
    )
  );

  static BoxDecoration fiBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(50.0),
      topRight: Radius.circular(50.0)
    )
  );

  static BoxDecoration btnCancel = BoxDecoration(
    border: Border.all(
      color: Colors.red
    ),
    borderRadius: BorderRadius.circular(25.0)
  );

  static BoxDecoration btnOk = BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(25.0)
  );

  static BoxDecoration bsCategory = BoxDecoration(
    border: Border.all(
      color: Colors.grey 
    ),
    borderRadius: BorderRadius.circular(20.0)
  );

  static RoundedRectangleBorder bottomSheet = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0)
    )
  );

  static BoxDecoration flayer = BoxDecoration(
    color: Colors.white,
    border: Border.all(
      color: Colors.blue
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(25.0)
    )
  );

  static BoxDecoration gridBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(20.0))
  );
}

