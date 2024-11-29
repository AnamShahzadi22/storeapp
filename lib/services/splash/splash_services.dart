import 'dart:async';
import 'package:flutter/material.dart';
import 'package:store_app/view/home/home_page.dart';

class SplashService {
  final BuildContext context;

  SplashService(this.context);

  void startTimer() {
    Timer(Duration(seconds: 3), navigateToHome);
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}