import 'package:expenses_app/widgets/setting_page_wt/cancel_notif.dart';
import 'package:expenses_app/widgets/setting_page_wt/dark_mode.dart';
import 'package:expenses_app/widgets/setting_page_wt/time_picker.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: ListView(
        children: [
          DarkMode(),
          Divider(thickness: 2),
          CancelNotif(),
          TimePicker(),
          Divider(thickness: 2),
        ],
      )
    );
  }
}