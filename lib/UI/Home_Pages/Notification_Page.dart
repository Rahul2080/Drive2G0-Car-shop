import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    return Scaffold(
      body: message==null? SizedBox():Column(
        children: [ Text("Message: ${message.notification?.title ?? 'No title'}"),
          Text(message.notification!.body.toString()),],
      ),
    );
  }
}
