import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:clevercheckin/widgets/widgets.dart';
import 'package:clevercheckin/utils/utils.dart';

class PageForgotPassword extends StatefulWidget {
  @override
  _PageForgotPasswordState createState() => _PageForgotPasswordState();
}

class _PageForgotPasswordState extends State<PageForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  bool isLoading = false;

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(children: <Widget>[
            ClipPath(
            clipper: BottomShapeClipper(),
            child: Container(
              color: colorCurve,
            )),
              SingleChildScrollView(
            child: SafeArea(
              top: true,
              bottom: false,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.getWidthPx(20), vertical: size.getWidthPx(20)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _forgotGradientText(),
                      SizedBox(height: size.getWidthPx(10)),
                      _textForgtPwd(),
                      SizedBox(height: size.getWidthPx(30)),
                      _emailFeild()
                    ]),
              ),
            ),
          )
        ]
       )
    );
    
  }

  RichText _textForgtPwd() {
    return RichText(
      text: TextSpan(
          text: "Provide your Email ID. We will send you password reset link. OR",
          children: [
            TextSpan(
              style: TextStyle(color: Colors.deepOrange),
              text: ' Back to Login', 
              recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pop(context),             
            )
          ],
          style: TextStyle(fontFamily: 'Exo2',color: Colors.black87, fontSize: 16)),
    );
  }

  GradientText _forgotGradientText() {
    return GradientText('Forgot password ?',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(97, 6, 165, 1.0),
          Color.fromRGBO(45, 160, 240, 1.0)
        ]),
        style: TextStyle(
            fontFamily: 'Exo2', fontSize: 30, fontWeight: FontWeight.bold));
  }

  BoxField _emailWidget() {
    return BoxField(
      hintText: "Please provide your email ID",
      lableText: "Email",
      obscureText: false,
      onSaved: (String val) {},
      validator: validateEmail,
      icon: Icons.email,
      iconColor: Colors.cyan,
    );
  }
  Container _backButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.getWidthPx(20), 
      ),
      width: size.getWidthPx(50),
      child: FlatButton(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[                      
              Icon(Icons.arrow_back_ios, color: Colors.deepOrange),
            ],
        ),
        onPressed: (){
          Navigator.pop(context, false);
        }
      ),
    );
  }
  _emailFeild() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _emailWidget(),
          SizedBox(height: size.getWidthPx(20)),
          Row(
            children: <Widget>[
              _backButtonWidget(),
              _submitButtonWidget(),
          ]),
        ],
      );

  Container _submitButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.getWidthPx(20), 
        horizontal: size.getWidthPx(16)
      ),
      width: size.getWidthPx(200),
      child: RaisedGradientButton(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[                      
              Icon(Icons.lock_open, color: Colors.white),
              Text(' Submit ', style: TextStyle(fontFamily: 'Exo2',color: Colors.white, fontSize: 20.0))
            ],
        ),
        gradient: LinearGradient(
          colors: ccGradientPrimary,
        ),
        onPressed: (){
          _validateInputs();
        }
      ),
    );
  }

  String validateEmail(String value) {
    RegExp regExp = RegExp(Constants.PATTERN_EMAIL, caseSensitive: false);

    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter valid email address.";
    }
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      // Go to Dashboard
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
