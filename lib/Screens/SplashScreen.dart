import 'package:dweerha/HomeScreen.dart';
import 'package:dweerha/Utils/SharedPrefManager.dart';
import 'package:flutter/material.dart';
import 'package:dweerha/Constraints/colors.dart';
import 'package:dweerha/Widgets/AppLogo.dart';
import 'WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<int> id;
  @override
  Widget build(BuildContext context) {
    Duration d = Duration(seconds: 3);
    Future.delayed(d, () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FutureBuilder<int>(
                    future: id,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == 0) {
                          return WelcomeScreen();
                        } else {
                          return HomeScreen();
                        }
                      }
                    },
                  )));
    });
    return Scaffold(
      backgroundColor: Color(background_color),
      body: Center(
        child: AppLogo(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    id = getId();
  }
}
