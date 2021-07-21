
import 'package:expenses_app/utils/icon_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// extension IconDataExtension on String{
//   toIcon(){
//     var hexIcon = this;
//     return IconData(int.parse(hexIcon), fontFamily: 'MaterialIcons');
//   }
// }

extension IconDatas on String {
  toIcons(){
    var iconData = this;
    return IconPicker().iconMap[iconData];
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