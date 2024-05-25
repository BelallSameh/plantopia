import 'package:flutter/material.dart';
import 'package:plantopia/classes/notification_class.dart';
import 'package:plantopia/classes/plantclass.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  void addNotification(NotificationModel notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void removeNotification(NotificationModel notification) {
    _notifications.remove(notification);
    notifyListeners();
  }

  void removeAllNotifications() {
    _notifications.clear(); // Clears all notifications from the list
    notifyListeners();
  }

  String getPlantNameFromId(String plantId, List<Plant> plants) {
    Plant? plant = plants.firstWhere((plant) => plant.id == plantId);
    return plant.name;
  }
}
