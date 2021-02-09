import 'package:flutter/material.dart';
import 'package:dweerha/Utils/AppLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslate(BuildContext context,String key){
  return AppLocalization.of(context).getTranslatedValue(key);
}

void setLocale(String languageCode) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString('languageCode', languageCode);
}

Future<Locale> getLocale() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString('languageCode') ?? Locale('ar','SA');
}