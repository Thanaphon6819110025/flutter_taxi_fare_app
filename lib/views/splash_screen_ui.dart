import 'dart:async';
import 'package:flutter/material.dart';
import 'taxi_fare_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TaxiFareUi()),
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //  ใส่รูปแท็กซี่ตรงนี้ 
              Image.asset(
                'assets/images/619006.png',
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              const Text(
                'Taxi Fare Calculator',
                style: TextStyle(
                  color: Color(0xFF7DB2E8),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'คำนวณค่าโดยสารแท็กซี่',
                style: TextStyle(color: Color(0xFF7DB2E8), fontSize: 12),
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(
                color: Color(0xFFF5C242),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      );
}