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
  String get temperature => 'Temperatura';

  @override
  String get max_temperature => 'Max';

  @override
  String get min_temperature => 'Min';

  @override
  String get feels_like => 'Sensação Térmica';

  @override
  String get wind => 'Vento';

  @override
  String get wind_direction => 'Direção';

  @override
  String get wind_speed => 'Velocidade';

  @override
  String get rain => 'Chuva';

  @override
  String get precipitation => 'Precipitação';

  @override
  String get other => 'Misc';

  @override
  String get humidity => 'Umidade';

  @override
  String get pressure => 'Pressão';
}
