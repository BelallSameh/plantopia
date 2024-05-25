import 'package:flutter/material.dart';

class NotificationModel {
  final IconData icon;
  final String plantId; // Changed from plantName
  final String careInfo;

  NotificationModel({
    required this.icon,
    required this.plantId, // Changed from plantName
    required this.careInfo,
  });
}

