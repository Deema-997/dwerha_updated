import 'package:dweerha/APIs/apis.dart';
import 'package:dweerha/Screens/RegisterScreen.dart';
import 'package:dweerha/Utils/BaseFunctions.dart';
import 'package:dweerha/Utils/SharedPrefManager.dart';
import 'package:dweerha/Widgets/LoginField.dart';
import 'package:dweerha/Widgets/NewButton.dart';
import 'package:flutter/material.dart';
import 'package:dweerha/Widgets/AppLogo.dart';
import 'package:dweerha/Constraints/styles.dart';
import 'package:dweerha/Utils/locale_constant.dart';
import 'package:dweerha/Constraints/colors.dart';

import '../HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber;

  String password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('تسجيل الدخول'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(tag: 'logo', child: AppLogo()),
            SizedBox(height: 20.0),
            Text(
              getTranslate(context, 'login'),
              style: normalStyle,
            ),
            LoginField(
              keyboardType: TextInputType.phone,
              hint: getTranslate(context, 'mobile_number'),
              onChange: (v) {
                phoneNumber = v;
              },
            ),
            LoginField(
              keyboardType: TextInputType.text,
              isPassword: true,
              hint: getTranslate(context, 'password'),
              onChange: (v) {
                password = v;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Visibility(
              visible: isLoading ? false : true,
              child: NewButton(
                onPressed: () {
                  if (phoneNumber.isEmpty) {
                    showToast(context, 'يجب عليك كتابة رقم الجوال');
                    return;
                  }
                  if (password.isEmpty) {
                    showToast(context, 'يجب عليك كتابة كلمة المرور');
                    return;
                  }
                  login();
                },
                title: getTranslate(context, 'login'),
              ),
            ),
            Visibility(
              visible: isLoading ? true : false,
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
            Text(
              getTranslate(context, 'no_account'),
              style: textFieldTextStyle,
            ),
            SizedBox(
              height: 5.0,
            ),
            FlatButton(
              padding: EdgeInsets.zero,
              child: Text(
                getTranslate(context, 'new_register'),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    decoration: TextDecoration.underline),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    setState(() {
      isLoading = true;
    });
    var data = await APIs.login(phoneNumber, password);
    setState(() {
      isLoading = false;
    });
    if (data != null) {
      int status = data['status'];
      if (status == 1) {
        int id = data['user']['id'];
        await setId(id);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      } else {
        String message = data['msg'];
        showToast(context, message);
      }
    } else {
      showToast(context, 'حدث خطأ ما');
    }
  }
}
