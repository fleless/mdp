import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_theme.dart';
import 'package:mdp/utils/app_localization.dart';
import 'package:mdp/utils/shared_preferences.dart';

class AppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sharedPref = Modular.get<SharedPref>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1)).then(
        (value) => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.black,
              systemNavigationBarDividerColor: Colors.black,
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.black,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            )));

    /// handling push notifications functions
    initialize(context);
    _initFlutterDownloaderPackage();
  }

  _initFlutterDownloaderPackage() async {
    await FlutterDownloader.initialize(
        debug: false // optional: set false to disable printing logs to console
        );

    ///when app is terminated or closed gives you the message on which user taps
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        if (message.data != null) {
          if ((message.data['order'] != null) &&
              (message.data['competition'] != null)) {
            await Future.delayed(Duration(seconds: 5));
            if (sharedPref.read(AppConstants.TOKEN_KEY) != null) {
              Modular.to.pushNamed(Routes.notifications, arguments: {
                "uuidIntervention": message.data['order'],
                "uuidCompetition": message.data['competition']
              });
            }
          }
        }
      }
    });

    ///Only work on Foreground listener
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        if ((event.data['order'] != null) &&
            (event.data['competition'] != null)) {
          Fluttertoast.showToast(
              msg: 'Vous avez reçu une nouvelle proposition de commande');
        }
      }
    });

    ///when app is in background but opened and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.data != null) {
        if ((event.data['order'] != null) &&
            (event.data['competition'] != null)) {
          Modular.to.pushNamed(Routes.notifications, arguments: {
            "uuidIntervention": event.data['order'],
            "uuidCompetition": event.data['competition']
          });
        }
      }
    });
  }

  Future initialize(context) async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
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

  @override
  void dispose() {
    super.dispose();
  }
}
