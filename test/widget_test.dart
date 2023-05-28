// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quanlysanbong/Firebase/DatSan_Data.dart';

import 'package:quanlysanbong/main.dart';

void main() {
   void getAll(){
    final datSanList = DatSanSnapShot.getAll();
    final sanCollection = FirebaseFirestore.instance.collection('San').snapshots();
    datSanList.map((datSan) {
      print(datSan);
    });
  }
   getAll();
}
