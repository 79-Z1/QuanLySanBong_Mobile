import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlysanbong/Authen/LoginPage.dart';
import 'package:quanlysanbong/Booking/BookingPage.dart';
import 'package:quanlysanbong/History/HistoryPage.dart';
import 'package:quanlysanbong/Rss/Page/PageRss.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: QuanLySanBongApp(),
    );
  }
}