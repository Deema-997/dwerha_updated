import 'package:shared_preferences/shared_preferences.dart';

Future<List<double>> getCachedCoords() async {
  List<double> output = [];
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  double lat = sharedPreferences.getDouble('my_lat') ?? 0.0;
  double lng = sharedPreferences.getDouble('my_lng') ?? 0.0;
  output.add(lat);
  output.add(lng);
  return output;
}

Future setId(int id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt('id', id);
  return id;
}

Future<int> getId() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int id = sharedPreferences.getInt('id') ?? 0;
  return id;
}
