// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get language => 'portugues';

  @override
  String get temperature_label => 'Temperatura';

  @override
  String get wind_label => 'Vento';

  @override
  String get rain_label => 'Chuva';

  @override
  String get other_label => 'Misc';
}
