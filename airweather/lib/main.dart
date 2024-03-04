import 'package:airweather/pages/home.dart';
import 'package:airweather/pages/loading.dart';
import 'package:airweather/pages/select_location.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const home(),
      '/location': (context) => const SelectLocation()
    },
  ));
}