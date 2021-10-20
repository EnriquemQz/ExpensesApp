import 'package:expenses_app/providers/local_notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:provider/provider.dart';

class TimePicker extends StatefulWidget {
  TimePicker({Key key}) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final _prefs = UserPrefs();
  bool _enable = false;
  @override
  Widget build(BuildContext context) {
    
    final DateTime setTime = DateTime.now();
    String currentTime;

    if(_prefs.hour != 'Null'){
      final DateTime getTime = DateTime(
        setTime.year,
        setTime.month,
        setTime.day,
        _prefs.hour,
        _prefs.minute
      );
      _enable = true;
      currentTime = DateFormat.jm().format(getTime);
    } else {
      _enable = false;
      currentTime = 'Desactivado';
    }

    return ListTile(
      enabled: _enable,
      leading: (_enable)
      ? Icon(Icons.notifications_active_outlined, size: 35.0)
      : Icon(Icons.notifications_off_outlined, size: 35.0),
      title: Text('Recordatorio diario'),
      subtitle: Text(currentTime),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: (){
        _selectTime();
      },
    );
  }

  _selectTime(){
    int _hour;
    int _minute;

    _getTime(int hour, int minute){
      setState(() {
        _hour = hour;
        _minute = minute;
      });
    }
    showModalBottomSheet(
      shape: DarkMode.bottomSheet,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (context){
        final _notification = 
          Provider.of<LocalNotificationProvider>(context, listen: false);
        return Container(
          height: 350.00,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Establece una hora para enviar una notificación',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.5
                  ),
                )
              ),
              Container(
                child: TimePickerSpinner(
                  time: DateTime.now(),
                  is24HourMode: false,
                  spacing: 60,
                  itemWidth: 60,
                  itemHeight: 60,
                  isForce2Digits: true,
                  normalTextStyle: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey
                  ),
                  highlightedTextStyle: TextStyle(
                    fontSize: 38.0,
                    color: Colors.green,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold
                  ),
                  onTimeChange: (time){
                    _getTime(time.hour, time.minute);
                  }
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: DarkMode.btnCancel,
                          child: Center(
                            child: Text('CANCELAR'),
                          ),
                        ),
                      )
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _notification.zonedScheduled(_hour, _minute);
                            _prefs.hour = _hour;
                            _prefs.minute = _minute;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: DarkMode.btnOk,
                          child: Center(
                            child: Text('ACEPTAR'),
                          ),
                        ),
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}