import 'package:dweerha/HomeScreen.dart';
import 'package:dweerha/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dweerha/Utils/AppLocalization.dart';
import 'package:dweerha/Constraints/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: Color(text_color)),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      locale: Locale('ar', 'SA'),
      supportedLocales: [Locale('ar', 'SA')],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode) {
            return deviceLocale;
          }
        }

        return supportedLocales.first;
      },
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
