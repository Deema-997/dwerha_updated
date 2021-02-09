import 'package:http/http.dart';
import 'dart:convert';

class APIs {
  static var loginUrl = "/login";
  static var registerUrl = "/register";

  static Future<dynamic> login(String phone, String password) async {
    Response response = await post(loginUrl,
        body: {'phone': phone, 'password': password},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    if (response.statusCode == 200) {
      String body = response.body;
      var data = jsonDecode(body);
      return data;
    } else {
      return null;
    }
  }

  static Future<dynamic> register(String full_name, String phone, String email,
      String lat, String lng, String password, int type) async {
    Response response = await post(registerUrl, body: {
      'full_name': full_name,
      'phone': phone,
      'email': email,
      'lat': lat,
      'lng': lng,
      'password': password
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    });
    if (response.statusCode == 200) {
      String body = response.body;
      var data = jsonDecode(body);
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
