
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clevercheckin/utils/utils.dart';
import 'package:clevercheckin/widgets/widgets.dart';
import 'package:clevercheckin/model/models.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Screen size;

  List<Property> premiumList =  List();

  @override
  void initState() {
    super.initState();
    premiumList
    ..add(Property(propertyName:"XYZ Villa", propertyLocation:"Lonavala", image:"feature_1.jpg", propertyPrice:"Amenities..."))
    ..add(Property(propertyName:"Ye Woh Villa", propertyLocation:"Lonavala", image:"feature_2.jpg", propertyPrice:"Amenities..."))
    ..add(Property(propertyName:"Sangath Heights", propertyLocation:"Pune ", image:"feature_3.jpg", propertyPrice:"19.0 Cr"))
    ..add(Property(propertyName:"Adani HighRise", propertyLocation:"Mumbai ", image:"hall_1.jpg", propertyPrice:"22.5 Cr"));
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: backgroundColor),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[upperPart()],
            ),
          ),
        ),
      ),
    );
  }

  Widget upperPart() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: size.getWidthPx(100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 5, 138, 255), Color.fromARGB(255, 50, 250, 213)],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.getWidthPx(36)),
              child: Column(
                children: <Widget>[
                  titleWidget(),
                  SizedBox(height: size.getWidthPx(30)),
                ],
              ),
            ),
            
            Divider(),
            leftAlignText(
                text: "Mamtaa Villa",
                leftPadding: size.getWidthPx(18),
                textColor: textPrimaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 16.0),            
            HorizontalList(
              children: <Widget>[
                for (int i = 0; i < premiumList.length; i++)
                  propertyImgs(premiumList.reversed.toList()[i])
              ],
            ),
            leftAlignText(
              //"\n • 12 Guests\n • 4 Bedrooms\n • 4 Beds\n • 2 Baths\n • Kitchen\n • Swimming Pool",
              text: "12 Guests • 4 Bedrooms • 4 Beds • 2 Baths • Kitchen • Swimming Pool",
              leftPadding: size.getWidthPx(18),
              textColor: textPrimaryColor,
              fontSize: 16.0
            ),
            Align(
              alignment: Alignment(-0.85, 0),
              child: RichText(
                textAlign: TextAlign.left,
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.deepOrange,
                  ),
                  children: <TextSpan>[
                    new TextSpan(text: 'Weekend : ', style: ccText),
                    new TextSpan(text: '₹13,000/-', style: ccText),
                  ],
                ),
              ), 
            ),
            Align(
              alignment: Alignment(-0.85, 0),
              child: RichText(
                textAlign: TextAlign.left,
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.orange,
                  ),
                  children: <TextSpan>[
                    new TextSpan(text: 'Weekday : ', style: ccText3),
                    new TextSpan(text: '₹10,000/-', style: ccText3),
                  ],
                ),
              ), 
            ),
            
          ],
        ),
      ],
    );
  }

  Text titleWidget() {
    return Text("My Favourites",
        style: TextStyle(
            fontFamily: 'Exo2',
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.white));
  }

  Padding leftAlignText({text, leftPadding, textColor, fontSize, fontWeight}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text??"",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor)),
      ),
    );
  }

  /* Shows Images of ONE Property in a row */
  Card propertyImgs(Property property) {
    return Card(
        //elevation: 4.0,
        margin: EdgeInsets.fromLTRB(16, 2, 2, 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        //borderOnForeground: true,
        child: Container(
            //height: size.getWidthPx(150),
            width: size.getWidthPx(200),
            //padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.0),
                        topRight: Radius.circular(2.0)),
                    child: Image.asset('assets/${property.image}',
                        fit: BoxFit.fill)),
              ],
            )));
  }
}