import 'package:shared_preferences/shared_preferences.dart';

class LastUpdateService {
  static const lastUpdateKey = 'lastUpdate';

  Future<void> saveUpdateTime() async {
    final date = DateTime.now();
    final millis = date.millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastUpdateKey, millis);
  }

  Future<DateTime?> loadUpdateTime() async {
    final prefs = await SharedPreferences.getInstance();
    final int? millis = prefs.getInt(lastUpdateKey);

    if (millis == null) {
      final date = DateTime.now();
      final millis = date.millisecondsSinceEpoch;
      await prefs.setInt(lastUpdateKey, millis);
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(millis);
  }
}
