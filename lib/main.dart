import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stand_chat_app/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stand_chat_app/utils/services/notification_services.dart';

import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(
      NotificationServices.services.firebaseMessagingBackgroundHandler);

  NotificationServices.services.initNotification();
  NotificationServices.services.getFCM();

  runApp(
   GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: app_route,
      ),
  );
}