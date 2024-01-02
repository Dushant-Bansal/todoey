import 'package:shared_preferences/shared_preferences.dart';

class Persistence {
  static SharedPreferences? _prefs;
  static String key = 'tasks';

  Persistence._();

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static List<String> getTasks() => _prefs!.getStringList(key) ?? [];

  static Future<void> addTasks(List<String> value) async {
    await _prefs!.setStringList(key, value);
  }
}
