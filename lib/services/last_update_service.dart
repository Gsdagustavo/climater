import 'dart:ui' as ui;

import 'package:climater/l10n/app_localizations_en.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations_pt.dart';

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

  String getLastUpdateFormatted({String? languageCode}) {
    // debugPrint('GOT LAST UPDATE FORMATTED');
    final now = DateTime.now();
    final diff = now.difference(lastUpdateTime);

    if (diff.inSeconds < 60) {
      return _getJustNowText();
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} ${_getMinutesAgoText()}';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ${_getHoursAgoText()}';
    } else {
      return '${diff.inDays} ${_getDaysAgoText()}';
    }
  }
}

String _getJustNowText({String? languageCode}) {
  final lang = languageCode ?? ui.window.locale.languageCode;

  switch (lang) {
    case 'en':
      return AppLocalizationsEn().just_now_text;
    case 'pt':
      return AppLocalizationsPt().just_now_text;
    default:
      return 'Just now';
  }
}

String _getMinutesAgoText({String? languageCode}) {
  final lang = languageCode ?? ui.window.locale.languageCode;

  switch (lang) {
    case 'en':
      return AppLocalizationsEn().minutes_ago_text;
    case 'pt':
      return AppLocalizationsPt().minutes_ago_text;
    default:
      return 'minutes ago';
  }
}

String _getHoursAgoText({String? languageCode}) {
  final lang = languageCode ?? ui.window.locale.languageCode;

  switch (lang) {
    case 'en':
      return AppLocalizationsEn().hours_ago_text;
    case 'pt':
      return AppLocalizationsPt().hours_ago_text;
    default:
      return 'hours ago';
  }
}

String _getDaysAgoText({String? languageCode}) {
  final lang = languageCode ?? ui.window.locale.languageCode;

  switch (lang) {
    case 'en':
      return AppLocalizationsEn().days_ago_text;
    case 'pt':
      return AppLocalizationsPt().days_ago_text;
    default:
      return 'days ago';
  }
}
