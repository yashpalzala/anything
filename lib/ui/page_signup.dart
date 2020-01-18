import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:clevercheckin/utils/utils.dart';
import 'package:clevercheckin/widgets/widgets.dart';
import 'package:http/http.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController =  TextEditingController();
  TextEditingController _phoneController =  TextEditingController();
  TextEditingController _passwordController =  TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  FocusNode _nameFocusNode =  FocusNode();
  FocusNode _phoneFocusNode =  FocusNode();
  FocusNode _passFocusNode =  FocusNode();
  FocusNode _confirmPassFocusNode =  FocusNode();
  String _name, _phone, _password, _confirmPassword;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 
  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
        key: _scaffoldKey,
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
                  _signUpGradientText(),
                  SizedBox(height: size.getWidthPx(10)),
                  _textAccount(),
                  SizedBox(height: size.getWidthPx(30)),
                  registerFields()
                ]),
          ),
        ),
      )
    ]));
  }

  RichText _textAccount() {
    return RichText(
      text: TextSpan(
          text: "Already Signed Up ? ",
          children: [
            TextSpan(
              style: TextStyle(color: Colors.deepOrange),
              text: 'Login here',
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pop(context),
            )
          ],
          style: TextStyle(fontFamily: 'Exo2',color: Colors.black87, fontSize: 16)),
    );
  }

  GradientText _signUpGradientText() {
    return GradientText('Sign Up !',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(97, 6, 165, 1.0),
          Color.fromRGBO(45, 160, 240, 1.0)
        ]),
        style: TextStyle(fontFamily: 'Exo2',fontSize: 36, fontWeight: FontWeight.bold));
  }

  BoxField _nameWidget() {
    return BoxField(
        controller: _nameController,
        focusNode: _nameFocusNode,
        hintText: "Your Name",
        lableText: "Name",
        obscureText: false,
        onSaved: (String val) {
          _name = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_phoneFocusNode);
        },
        icon: Icons.person,
        iconColor: Colors.cyan);
  }

  BoxField _phoneWidget() {
    return BoxField(
        controller: _phoneController,
        focusNode: _phoneFocusNode,
        hintText: "Your Mobile Number",
        lableText: "Mobile Number",
        obscureText: false,
        onSaved: (String val) {
          _phone = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passFocusNode);
        },
        icon: Icons.phone,
        iconColor: Colors.cyan);
  }

  BoxField _passwordWidget() {
    return BoxField(
        controller: _passwordController,
        focusNode: _passFocusNode,
        hintText: "Set a Password",
        lableText: "Password",
        obscureText: true,
        icon: Icons.lock_outline,
        onSaved: (String val) {
          _password = val;
        },
        iconColor: Colors.cyan);
  }

  BoxField _confirmPasswordWidget() {
    return BoxField(
        controller: _confirmPasswordController,
        focusNode: _confirmPassFocusNode,
        hintText: "Confirm your Password",
        lableText: "Confirm Password",
        obscureText: true,
        icon: Icons.lock_outline,
        validator: (value){
          if (value.isEmpty) {
            return 'Please confirm your password!';
          }
          else{
            return null;
          }
        },        
        onSaved: (String val) {
          _confirmPassword = val;
        },
        iconColor: Colors.cyan
    );
  }

  Container _signUpButtonWidget() {
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
              Icon(Icons.check_circle, color: Colors.white),
              Text(' Sign Up ', style: TextStyle(fontFamily: 'Exo2',color: Colors.white, fontSize: 20.0))
            ],
        ),
        gradient: LinearGradient(
          colors: ccGradientDefault,
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            // Set All variables to values of textfields
            _formKey.currentState.save();
            print('valid');
          
            _scaffoldKey.currentState.showSnackBar(
                new SnackBar(duration: new Duration(seconds: 4), content:
                  new Row(
                    children: <Widget>[
                      new CircularProgressIndicator(),
                      new Text("  Finishing up...")
                    ],
                  ),
                )
            );
            await _handleSignUp(); 
            Navigator.pop(context, false);
          }
        }
      ),
    );
  }

  Future<bool> _handleSignUp() async {
    String url = 'http://clevercheckin.com/api/user/push_add';
    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
    if (_password.isEmpty ||  _name.isEmpty || _phone.isEmpty){
      return false;
    }else{
      Map<String, String>  params = {"name": _name, "mobile": _phone, "pass": _password };
      Response response = await post(url, headers: headers, body: params);
      if (response.statusCode == 200){
        //print(response.body);
        return true;
      }
    }
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


  GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: size.getWidthPx(20),
        backgroundColor: Colors.white,
        child: Image.asset(assetIcon),
      ),
    );
  }

  registerFields() => Container(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _nameWidget(),
                _phoneWidget(),
                _passwordWidget(),
                _confirmPasswordWidget(),
                Row(
                    children: <Widget>[
                      _backButtonWidget(),
                      _signUpButtonWidget(),
                    ]
                )
              ],
            )),
      );
}
