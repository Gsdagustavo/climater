// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'english';

  @override
  String get temperature_label => 'Temperature';

  @override
  String get wind_label => 'Wind';

  @override
  String get rain_label => 'Rain';

  @override
  String get other_label => 'Other';
}
