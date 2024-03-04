import 'dart:convert';

import 'package:http/http.dart';

class Weather {
  late String temperature;
  late String temperatureMin;
  late String temperatureMax;
  late String icon;
  late String condition;
  late String location;
  late DateTime time;
  late bool isDay;

  Weather({required this.location});

  Future<void> getData() async {
    try {
  
      String url =
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=49fab5ad026cb09b36ca4f22d7d313ed';
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      temperature = (data['main']['temp'] - 273.15).toStringAsFixed(1);
      temperatureMin = (data['main']['temp_min'] - 273.15).toStringAsFixed(0);
      temperatureMax = (data['main']['temp_max'] - 273.15).toStringAsFixed(0);
      condition = (data['weather'][0]['main']);
      icon = (data['weather'][0]['icon']);


      int timeStamp = (data['dt'] - 21600); // GMT+0600 to GMT+0000
      int timeZone = (data['timezone']);

      time = DateTime.fromMillisecondsSinceEpoch((timeStamp  + timeZone) * 1000); // GMT+0000 to destination city timezone

      // print(time);
      isDay = time.hour > 6 && time.hour < 19 ? true : false;
    } catch (err) {
      print(err);
      temperature = "Couldn't get data";
    }
  }
}