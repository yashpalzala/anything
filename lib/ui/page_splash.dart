import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clevercheckin/utils/utils.dart';

import '../LocalBindings.dart';
import 'page_home.dart';
import 'page_login.dart';
import 'page_onboarding.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Screen size;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
       navigateFromSplash();
    });
  }

  @override
  Widget build(BuildContext context) {
     size = Screen(MediaQuery.of(context).size);
    return Scaffold(        
        body: Center(
          child: Container(
            width: size.getWidthPx(128),
            /*height: size.getWidthPx(128),*/
            child: Image.asset("assets/icons/logo_splash.png")
          )
        )
    );
  }

  Future navigateFromSplash () async {

    String isOnBoard = await LocalStorage.sharedInstance.readValue(Constants.isOnBoard);
      print("isOnBoard  $isOnBoard");
      if(isOnBoard ==null || isOnBoard == "0"){
        //Navigate to OnBoarding Screen ui/page_onboarding.dart
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingPage()));
      }else{
        // Navigate to Login Page ui/page_login.dart
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
  }
}