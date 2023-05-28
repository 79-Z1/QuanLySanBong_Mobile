import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:quanlysanbong/Firebase/BangGiaSan_Data.dart';
import 'package:quanlysanbong/Firebase/JoinTable.dart';
import 'package:quanlysanbong/Firebase/TaiKhoan_Data.dart';

extension DateOnlyCompare on DateTime {
  bool compareDate(DateTime other) {
    if(year >= other.year && month > other.month) {
      return true;
    } else if(month == other.month) {
      if(day >= other.day) return true;
      else return false;
    } else return false;
  }
}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}









