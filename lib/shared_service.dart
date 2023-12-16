import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static late SharedPreferences pref;
  init() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<bool> savedata({required String key, required dynamic value}) async {
    if (value is bool) {
      return await pref.setBool(key, value);
    }
    if (value is String) {
      return await pref.setString(key, value);
    }
    if (value is int) {
      return await pref.setInt(key, value);
    } else {
      return await pref.setDouble(key, value);
    }
  }

  dynamic getdata({required String key}) {
    return pref.get(key);
  }
}
