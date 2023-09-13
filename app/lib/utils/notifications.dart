import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paheli/models/wotd.dart';

initializeNotifications() {
  print('Initializing notifications');
  AwesomeNotifications().initialize('resource://drawable/ic_stat_no', [
    NotificationChannel(
        channelGroupKey: 'samvargani',
        channelKey: 'samvargani',
        channelName: 'Daily game notifications',
        channelDescription: 'One notification per day',
        icon: 'resource://drawable/ic_stat_no',
        defaultColor: const Color.fromARGB(255, 255, 123, 0),
        enableVibration: false,
        ledColor: const Color.fromARGB(255, 255, 132, 0)),
  ]);
}

Future<bool> hasPermissions() async {
  return await AwesomeNotifications().isNotificationAllowed();

  List<NotificationPermission> permissionsAllowed = await AwesomeNotifications()
      .checkPermissionList(
          channelKey: 'samvargani',
          permissions: [NotificationPermission.Alert]);
  print(permissionsAllowed);
  if (permissionsAllowed.contains(NotificationPermission.Alert)) {
    print('Permission granted');
  } else {
    print('Permission not granted');
  }
  return permissionsAllowed.contains(NotificationPermission.Alert);
}

Future<bool> requestPermissions() async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    bool pressedYes =
        await AwesomeNotifications().requestPermissionToSendNotifications();
    return pressedYes;
  } else
    print('Permissions already granted');
  return true;
}

setupNotification() async {
  print('setupNotification');
  bool r = await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
          timeZone: AwesomeNotifications.localTimeZoneIdentifier,
          hour: 9,
          minute: 0,
          second: 0,
          millisecond: 0,
          repeats: true),
      content: NotificationContent(
          id: 1,
          channelKey: 'samvargani',
          title: 'A new challange awaits you',
          body: 'Can you solve today\'s word of the day?'));
  print(r);

  if (kDebugMode) {
    r = await AwesomeNotifications().createNotification(
        schedule: NotificationCalendar(
            timeZone: AwesomeNotifications.localTimeZoneIdentifier,
            hour: DateTime.now().hour,
            minute: DateTime.now().minute + 1,
            second: 0,
            millisecond: 0,
            repeats: true),
        content: NotificationContent(
            id: 1,
            channelKey: 'samvargani',
            title: 'Debug: A new challange awaits you',
            body: 'Can you solve today\'s word?'));
  }
  print(r);
}
