import 'package:flutter/material.dart';
import 'package:dweerha/Widgets/AppLogo.dart';
import 'package:dweerha/Utils/locale_constant.dart';
import 'package:dweerha/Constraints/styles.dart';
import 'package:dweerha/Constraints/colors.dart';
import 'LoginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Hero(tag: 'logo', child: AppLogo()),
              Column(
                children: <Widget>[
                  Text(
                    getTranslate(context, 'title'),
                    style: logoStyle,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    getTranslate(context, 'desc'),
                    style: smallStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Column(
                  children: <Widget>[
                    Text(
                      getTranslate(context, 'welcome'),
                      style: logoStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.skip_next,
                          color: Colors.grey,
                          size: 30.0,
                        ),
                        Text(
                          getTranslate(context, 'skip'),
                          style: smallStyle,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
