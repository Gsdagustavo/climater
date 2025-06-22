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
  String get temperature => 'Temperature';

  @override
  String get max_temperature => 'Max';

  @override
  String get min_temperature => 'Min';

  @override
  String get feels_like => 'Feels Like';

  @override
  String get wind => 'Wind';

  @override
  String get wind_direction => 'Direction';

  @override
  String get wind_speed => 'Speed';

  @override
  String get rain => 'Rain';

  @override
  String get precipitation => 'Precipitation';

  @override
  String get other => 'Other';

  @override
  String get humidity => 'Humidity';

  @override
  String get pressure => 'Pressure';
}
