
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const DARK_MODE = 'darkMode';
  static const HOUR = 'hour';
  static const MINUTE = 'minute';

  static final UserPrefs _instance = new UserPrefs._();

  factory UserPrefs(){
    return _instance;
  }

  UserPrefs._();
  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get darkMode {
    return _prefs.getBool(DARK_MODE) ?? true;
  }

  set darkMode(bool value){
    _prefs.setBool(DARK_MODE, value);
  }

  get hour {
    return _prefs.getInt(HOUR) ?? 'Null';
  }

  set hour(int value){
    _prefs.setInt(HOUR, value);
  }

  get minute {
    return _prefs.getInt(MINUTE) ?? 'Null';
  }

  set minute(int value){
    _prefs.setInt(MINUTE, value);
  }

  deleteTime(){
    _prefs.remove(HOUR);
    _prefs.remove(MINUTE);
  }
}