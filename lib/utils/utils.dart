
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

extension IconDataExtension on String{
  toIcon(){
    var hexIcon = this;
    return IconData(int.parse(hexIcon), fontFamily: 'MaterialIcons');
  }
}

extension ColorExtension on String {
  toColor(){
    var hexColor = this.replaceAll('#', '');
    if(hexColor.length == 6){
      hexColor = 'FF'+ hexColor;
    }
    if(hexColor.length == 8){
      return Color(int.parse('0x$hexColor'));
    }
  }
}