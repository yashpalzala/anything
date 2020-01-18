import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clevercheckin/utils/utils.dart';
import 'package:clevercheckin/widgets/widgets.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isLocalNotification = true;
  bool isPushNotification = true;
  bool isPrivateAccount = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings",
            style:
                TextStyle(fontFamily: "Exo2", color: textSecondaryLightColor)),
        backgroundColor: backgroundColor,
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: backgroundColor),
        child: Container(
          color: backgroundColor,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox( height: 15.0, ),
                accountSection(),
                SizedBox( height: 15.0, ),
                pushNotificationSection(),
                SizedBox( height: 15.0, ),
                getHelpSection(),
                SizedBox( height: 15.0, ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SettingSection getHelpSection() {
    return SettingSection(
      headerText: "Get Help".toUpperCase(),
      headerFontSize: 15.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: TileRow(
            label: "Contact Us",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Terms and Condition",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Feedback",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Log out",
            disableDivider: false,
            onTap: () {},
          ),
        )
      ],
    );
  }

  SettingSection accountSection() {
    return SettingSection(
      headerText: "Account".toUpperCase(),
      headerFontSize: 15.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: TileRow(
            label: "Email",
            disabled: false,
            rowValue: "patil.rahuls@outlook.com",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Mobile Number",
            disabled: false,
            rowValue: "+91 9969965293",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Instagram Page",
            disabled: false,
            rowValue: "https://instagra...",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Facebook Page",
            disabled: false,
            rowValue: "https://fb.com/...",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Twitter Page",
            disabled: false,
            rowValue: "https://twitte...",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: SwitchRow(
            label: "Private Account",
            disableDivider: false,
            value: isPrivateAccount,
            onSwitchChange: (switchStatus) {
              setState(() {
                switchStatus
                    ? isPrivateAccount = true
                    : isPrivateAccount = false;
              });
            },
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "Change Password",
            disableDivider: false,
            onTap: () {},
          ),
        )
      ],
    );
  }

  SettingSection pushNotificationSection() {
    return SettingSection(
      headerText: "Configure Alerts".toUpperCase(),
      headerFontSize: 15.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: SwitchRow(
            label: "Push Notifications (All)",
            disableDivider: false,
            value: isPushNotification,
            onSwitchChange: (switchStatus) {
              setState(() {
                switchStatus
                    ? isPushNotification = true
                    : isPushNotification = false;
              });
            },
            onTap: () {},
          ),
        ),
        Container(
          child: SwitchRow(
            label: "Push Notifications (Favourites)",
            disableDivider: false,
            value: isLocalNotification,
            onSwitchChange: (switchStatus) {
              setState(() {
                switchStatus
                    ? isLocalNotification = true
                    : isLocalNotification = false;
              });
            },
            onTap: () {},
          ),
        )
      ],
    );
  }
}
