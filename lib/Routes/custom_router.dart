import 'package:dweerha/Screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:dweerha/Screens/SplashScreen.dart';
import 'route_names.dart';


class CustomRouter{
  static Route<dynamic> allRoutes(RouteSettings settings){
    switch(settings.name){
      case homePage:
        return MaterialPageRoute(builder: (_)=>SplashScreen());
      case aboutPage:
        return MaterialPageRoute(builder: (_)=>WelcomeScreen());
    }
    return MaterialPageRoute(builder: (_)=>Container());
  }
}