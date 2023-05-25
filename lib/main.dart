import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlysanbong/Authen/LoginPage.dart';
import 'package:quanlysanbong/Booking/BookingPage.dart';
import 'package:quanlysanbong/History/HistoryPage.dart';
import 'package:quanlysanbong/Home/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FireBaseHistory()
    );
  }
}
