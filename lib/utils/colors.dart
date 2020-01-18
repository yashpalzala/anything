import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

Color colorCurve = Colors.cyan;
Color colorCurveSecondary = Color.fromRGBO(252, 152, 66, 0.6);
Color backgroundColor =Colors.grey.shade200;
Color textPrimaryColor =Colors.black87;

//textColors
Color textPrimaryLightColor = Colors.white;
Color textPrimaryDarkColor = Colors.black;
Color textSecondaryLightColor = Colors.black87;
Color textSecondary54 = Colors.black54;
Color textSecondaryDarkColor = Colors.blue;
Color hintTextColor = Colors.white30;
Color bucketDialogueUserColor = Colors.red;
Color disabledTextColour = Colors.black54;
Color placeHolderColor = Colors.black26;
Color dividerColor = Colors.black26;

// Gradients
List<Color> ccGradientPrimary = [
    Color.fromARGB(255, 254, 95, 117),
    Color.fromARGB(255, 252, 152, 66),
  ];

List<Color> ccGradientDefault = [
    Color.fromARGB(255, 5, 138, 255),
    Color.fromARGB(255, 50, 250, 213),
  ];

/* For Applying Gradients to Texts */
Shader ccGradient = LinearGradient(
  colors: ccGradientPrimary,
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)
);

Shader ccGradient3 = LinearGradient(
  colors: ccGradientDefault,
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)
);
TextStyle ccText = new TextStyle(
        fontWeight: FontWeight.bold,
        foreground: Paint()..shader = ccGradient3);
TextStyle ccText3 = new TextStyle(
        fontWeight: FontWeight.bold,
        foreground: Paint()..shader = ccGradient);
/* RadialGradient for Icons */
RadialGradient ccRadialGradient = new RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: [Colors.red, Colors.blue],
                  tileMode: TileMode.mirror,
                );

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: width,
      height: 50.0,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[300],
          blurRadius: 40.0,
          offset: Offset(5.0, 5.0),
          spreadRadius: 10.0
        ),
      ], borderRadius: new BorderRadius.circular(30.0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}