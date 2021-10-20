import 'package:expenses_app/providers/local_notification_provider.dart';
import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelNotif extends StatefulWidget {
  CancelNotif({Key key}) : super(key: key);

  @override
  _CancelNotifState createState() => _CancelNotifState();
}

class _CancelNotifState extends State<CancelNotif> {
  final _prefs = new UserPrefs();
  bool _enable = false;
  String _title = 'Activar Notificaciones';
  LocalNotificationProvider _ntfProvider;
  UiProvider _uiProvider;

  @override
  void initState() {
    super.initState();
    if(_prefs.hour != 'Null'){
      _enable = true;
      _title = 'Desactivar Notificaciones';
    }
    _ntfProvider = 
      Provider.of<LocalNotificationProvider>(context, listen: false);
    _uiProvider = 
      Provider.of<UiProvider>(context, listen: false);
  }

  _cancelNotification(bool value){
    if(value == true){
      _prefs.hour = 21;
      _prefs.minute = 30;
      _ntfProvider.zonedScheduled(21, 30);
      _title = 'Desactivar Notificaciones';
      _uiProvider.selectedMenu = 2;
    } else {
      _ntfProvider.cancelNotification();
      _prefs.deleteTime();
      _title = 'Activar Notificaciones';
      _uiProvider.selectedMenu = 2;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _enable,
      title: Text(_title),
      onChanged: (value){
        setState(() {
          _enable = value;
          _cancelNotification(value);
        });
      },
    );
  }
}