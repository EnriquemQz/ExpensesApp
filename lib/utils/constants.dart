import 'package:flutter/material.dart';

class Constants {

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
}