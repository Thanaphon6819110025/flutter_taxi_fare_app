import 'package:flutter/material.dart';
import 'package:flutter_taxi_fare_app/views/splash_screen_ui.dart';

void main() => runApp(const TaxiFareApp());

class TaxiFareApp extends StatelessWidget {
  const TaxiFareApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taxi Fare Calculator',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFBF7FD)),
        home: SplashScreenUi(),
      );
}