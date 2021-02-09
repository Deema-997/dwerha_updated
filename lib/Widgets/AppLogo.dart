import 'package:flutter/material.dart';
import 'package:dweerha/Utils/locale_constant.dart';
import 'package:dweerha/Constraints/styles.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('images/logo.png',width: 30.0,height: 30.0,),
        Text(getTranslate(context, 'app_name'),style: logoStyle,)
      ],
    );
  }
}
