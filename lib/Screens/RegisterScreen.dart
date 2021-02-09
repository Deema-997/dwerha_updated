import 'package:dweerha/APIs/apis.dart';
import 'package:dweerha/Constraints/colors.dart';
import 'package:dweerha/Constraints/styles.dart';
import 'package:dweerha/HomeScreen.dart';
import 'package:dweerha/Screens/PickLocationScreen.dart';
import 'package:dweerha/Utils/BaseFunctions.dart';
import 'package:dweerha/Utils/SharedPrefManager.dart';
import 'package:dweerha/Utils/locale_constant.dart';
import 'package:dweerha/Widgets/LoginField.dart';
import 'package:dweerha/Widgets/NewButton.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLocationSelected = false;
  double selected_lat = 0.0;
  double selected_lng = 0.0;
  String fullName = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إنشاء حساب'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        children: <Widget>[
          Text(getTranslate(context, 'register_title'),
              textAlign: TextAlign.center, style: logoStyle),
          SizedBox(
            height: 20.0,
          ),
          LoginField(
            hint: getTranslate(context, 'full_name'),
            onChange: (v) {
              fullName = v;
            },
          ),
          SizedBox(
            height: 5.0,
          ),
          LoginField(
            keyboardType: TextInputType.phone,
            hint: getTranslate(context, 'mobile_number'),
            onChange: (v) {
              phoneNumber = v;
            },
          ),
          SizedBox(
            height: 5.0,
          ),
          LoginField(
            keyboardType: TextInputType.emailAddress,
            hint: getTranslate(context, 'email'),
            onChange: (v) {
              email = v;
            },
          ),
          Text(
            getTranslate(context, 'location'),
            style: textFieldTextStyle,
          ),
          Container(
            height: 40.0,
            child: FlatButton(
              child: Text(
                getTranslate(
                  context,
                  isLocationSelected ? 'location_selected' : 'select_location',
                ),
                style: isLocationSelected ? smallStyleWhite : smallStyle,
              ),
              color: isLocationSelected ? Color(text_color) : Colors.white,
              shape: OutlineInputBorder(
                borderSide: isLocationSelected
                    ? BorderSide.none
                    : BorderSide(color: Color(text_color), width: 1.0),
              ),
              onPressed: () async {
                try {
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setDouble('my_lat', position.latitude);
                  sharedPreferences.setDouble('my_lng', position.longitude);
                  var data = Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return PickLocationScreen();
                  }));
                  if (data != null) {
                    data.then((value) {
                      setState(() {
                        isLocationSelected = true;
                      });
                      selected_lat = value[0];
                      selected_lng = value[1];
                    });
                  }
                } catch (e) {}
              },
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          LoginField(
            isPassword: true,
            hint: getTranslate(context, 'password'),
            onChange: (v) {
              password = v;
            },
          ),
          SizedBox(
            height: 5.0,
          ),
          Visibility(
            visible: isLoading ? false : true,
            child: NewButton(
              onPressed: () async {
                if (fullName.isEmpty) {
                  showToast(context, 'يجب عليك كتابة اسمك الكامل');
                  return;
                }
                if (phoneNumber.isEmpty) {
                  showToast(context, 'يجب عليك كتابة رقم الجوال');
                  return;
                }
                if (email.isEmpty) {
                  showToast(context, 'يجب عليك كتابة البريد الإلكتروني');
                  return;
                }
                if (!isLocationSelected) {
                  showToast(context, 'يجب اختيار موقعك على الخريطة');
                  return;
                }
                setState(() {
                  isLoading = true;
                });
                var data = await APIs.register(
                    fullName,
                    phoneNumber,
                    email,
                    selected_lat.toString(),
                    selected_lng.toString(),
                    password,
                    1);
                setState(() {
                  isLoading = false;
                });
                if (data != null) {
                  int status = data['status'];
                  if (status == 1) {
                    int id = data['user']['id'];
                    await setId(id);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  } else {
                    String message = data['msg'];
                    showToast(context, message);
                  }
                } else {
                  showToast(context, 'حدث خطأ ما');
                }
              },
              title: getTranslate(context, 'register_btn'),
            ),
          ),
          Visibility(
            visible: isLoading ? true : false,
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
