import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clevercheckin/ui/page_splash.dart';
import 'ui/page_home.dart';
import 'ui/page_login.dart';
import 'ui/page_onboarding.dart';
import 'ui/page_settings.dart';
import 'utils/utils.dart';
import 'widgets/carousol.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleverCheckin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: CollectionApp(),
    );
  }
}

class CollectionApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
        ),
        home: SplashScreen() /* Show SplashScreen from ui/page_splash.dart */
    );
  }
}





