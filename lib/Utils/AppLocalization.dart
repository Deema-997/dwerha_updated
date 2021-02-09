import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AppLocalization{

  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Map<String, String> _localizedValues;

  Future load() async {
    String jsonStringValues = await rootBundle.loadString('lib/Lang/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key,value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key){
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{

  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar'].contains(locale.languageCode);
    //It could be return ['ar','en'].contains(locale.languageCode); if we had more than one language
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;

}