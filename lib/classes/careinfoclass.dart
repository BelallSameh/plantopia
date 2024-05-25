import 'package:flutter/material.dart';

class CareInfoModel {
  final String title;
  final IconData icon;
  late int daysLeft;
  late int maxDays;

  CareInfoModel({
    required this.title,
    required this.icon,
    required this.daysLeft,
    required this.maxDays,
  });
}