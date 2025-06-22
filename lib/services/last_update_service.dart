import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastUpdateService {
  static const lastUpdateKey = 'lastUpdate';
  DateTime lastUpdateTime = DateTime.now();

  Future<void> saveUpdateTime() async {
    debugPrint(
      'SAVE UPDATE TIME CALLED ON LAST UPDATE SERVICE. TIME: $lastUpdateTime',
    );

    lastUpdateTime = DateTime.now();
    final millis = lastUpdateTime.millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastUpdateKey, millis);
  }

  Future<void> loadUpdateTime() async {
    debugPrint(
      'LOAD UPDATE TIME CALLED ON LAST UPDATE SERVICE. TIME: $lastUpdateTime',
    );

    final prefs = await SharedPreferences.getInstance();
    final int? millis = prefs.getInt(lastUpdateKey);

    if (millis == null) {
      lastUpdateTime = DateTime.now();
      final millis = lastUpdateTime.millisecondsSinceEpoch;
      await prefs.setInt(lastUpdateKey, millis);
      return;
    }

    lastUpdateTime = DateTime.fromMillisecondsSinceEpoch(millis);
  }

  String getLastUpdateFormatted() {
    // debugPrint('GOT LAST UPDATE FORMATTED');
    final now = DateTime.now();
    final diff = now.difference(lastUpdateTime);

    if (diff.inSeconds < 60) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else {
      return '${diff.inDays} days ago';
    }
  }
}
