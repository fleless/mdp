import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_theme.dart';
import 'package:mdp/utils/app_localization.dart';

class AppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    _initFlutterDownloaderPackage();
  }

  _initFlutterDownloaderPackage() async {
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
    //when app is terminated or closed gives you the message on which user taps
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Modular.to.pushNamed(Routes.notifications);
      }
    });

    //Only work on Foreground listener
    FirebaseMessaging.onMessage.listen((event) {
      print("une notif reçue");
      if (event.notification != null) {
        print("l'evenement est" + event.notification.body);
        print("l'evenement est" + event.notification.title);
      }
    });

    //when app is in background but opened and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Modular.to.pushNamed(Routes.notifications);
      print("loulou");
      if (event.data != null) {
        print(event.data["route"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: AppConstants.title,
      theme: AppTheme.themeData,
      supportedLocales: AppLocalizations.supportedLocales(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: Modular.generateRoute,
      initialRoute: Routes.splash,
    );
  }

  Future<void> initPlatformState() async {}

  @override
  void dispose() {
    super.dispose();
  }
}
