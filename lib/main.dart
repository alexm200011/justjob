import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:justjob/models/user.dart';
import 'package:justjob/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:justjob/services/auth.dart';
import 'package:justjob/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:justjob/models/user.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Un mensaje se ha impreso: ${message.messageId}');
}


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MUser?>.value(
      value: AuthService().user,
      //--> por investigar
        initialData: null,
        child: MaterialApp(
          home: Wrapper(),
      ),
    );
  }
}

