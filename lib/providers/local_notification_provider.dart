
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart'as tz;

class LocalNotificationProvider extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


  Future initialize() async {
    AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final InitializationSettings initializationSettings = 
      InitializationSettings(
        android: androidInitializationSettings
      );
    
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  
  Future zonedScheduled(int hour, int minute) async {
    final tz.TZDateTime utcTime = tz.TZDateTime.now(tz.local);
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      utcTime.year,
      utcTime.month,
      utcTime.day,
      hour,
      minute
    );

    if(scheduleDate.isBefore(utcTime)){
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }

    var bigImage = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('@mipmap/ic_img'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      contentTitle: 'Es hora de registrar gastos',
      summaryText: 'No olvides registrar los gastos de tu día',
      htmlFormatContent: true,
      htmlFormatTitle: true
    );

    var _android = AndroidNotificationDetails(
      'id',
      'ChannelName',
      'ChannelDescription',
      styleInformation: bigImage
    );

    var platform = NotificationDetails(
      android: _android
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'LLego el momento',
      'No olvides registrar gastos',
      scheduleDate,
      platform,
      uiLocalNotificationDateInterpretation: 
        UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time
    );

    notifyListeners();
  }
  
  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}