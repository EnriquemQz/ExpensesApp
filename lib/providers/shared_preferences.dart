
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const DARK_MODE = 'darkMode';
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

}