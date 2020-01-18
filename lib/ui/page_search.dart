import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clevercheckin/model/models.dart';
import 'package:clevercheckin/utils/utils.dart';
import 'package:clevercheckin/utils/utils.dart' as prefix0;
import 'package:clevercheckin/widgets/widgets.dart';
import 'page_property_details.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  Screen size;
  int _selectedIndex = 1;

  List<Property> premiumList =  List();
  List<Property> featuredList =  List();
  var citiesList = ["Goa", "Lonavala", "Igatpuri ", "karjat"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    premiumList
    ..add(Property(propertyName:"XYZ Villa",propertyLocation:"Lonavala", image:"feature_1.jpg", propertyPrice:"Amenities..."))
    ..add(Property(propertyName:"Ye Woh Villa", propertyLocation:"Lonavala", image:"feature_2.jpg", propertyPrice:"Amenities..."))
    ..add(Property(propertyName:"Sangath Heights", propertyLocation:"Pune ", image:"feature_3.jpg", propertyPrice:"19.0 Cr"))
    ..add(Property(propertyName:"Adani HighRise", propertyLocation:"Mumbai ", image:"hall_1.jpg", propertyPrice:"22.5 Cr"))
    ..add(Property(propertyName:"N.G Tower", propertyLocation:"Gandhinagar ", image:"hall_2.jpeg", propertyPrice:"7.5 Cr"))
    ..add(Property(propertyName:"Vishwas CityRise", propertyLocation:"Pune ", image:"hall_1.jpg", propertyPrice:"17.5 Cr"))
    ..add(Property(propertyName:"Gift City", propertyLocation:"Ahmedabad ", image:"hall_2.jpeg", propertyPrice:"13.5 Cr"))
    ..add(Property(propertyName:"Velone City", propertyLocation:"Mumbai ", image:"feature_1.jpg", propertyPrice:"11.5 Cr"))
    ..add(Property(propertyName:"PabelBay", propertyLocation:"Ahmedabad ", image:"hall_1.jpg", propertyPrice:"33.1 Cr"))
    ..add(Property(propertyName:"Sapath Hexa Tower", propertyLocation:"Ahmedabad", image:"feature_3.jpg", propertyPrice:"15.6 Cr"));



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
            height: size.getWidthPx(240),
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
                  SizedBox(height: size.getWidthPx(10)),
                  upperBoxCard(),
                ],
              ),
            ),
            leftAlignText(
                text: "My Favourites",
                leftPadding: size.getWidthPx(16),
                textColor: Colors.red,
                fontWeight: FontWeight.w900,
                fontSize: 16.0),
            HorizontalList(
              children: <Widget>[
                for (int i = 0; i < premiumList.length; i++)
                  favPropertyCard(premiumList[i]) // Fav lists
              ],
            ),
            //////////////////////////////////////////////////
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
            //////////////////////////////////////////////////
          ],
        ),
      ],
    );
  }

  Text titleWidget() {
    return Text("Holiday Homes | Lonavala",
        style: TextStyle(
            fontFamily: 'Exo2',
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.white));
  }

  Card upperBoxCard() {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(20), vertical: size.getWidthPx(16)),
        borderOnForeground: true,
        child: Container(
          height: size.getWidthPx(150),
          child: Column(
            children: <Widget>[
              _searchWidget(),
              leftAlignText(
                  text: "Destinations :",
                  leftPadding: size.getWidthPx(16),
                  textColor: textPrimaryColor,
                  fontSize: 16.0),
              HorizontalList(
                children: <Widget>[
                  for(int i=0;i<citiesList.length;i++)
                    buildChoiceChip(i, citiesList[i])
                ],
              ),
            ],
          ),
        ));
  }

  BoxField _searchWidget() {
    return BoxField(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Search by location, Bungalow/Villa",
        lableText: "Search...",
        obscureText: false,
        onSaved: (String val) {},
        icon: Icons.search,
        iconColor: Colors.cyan);
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

  /* Shows Cards of Properties */
  Card favPropertyCard(Property property) {
    return Card(
        //elevation: 4.0,
        margin: EdgeInsets.all(2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        //borderOnForeground: true,
        child: GestureDetector(
          child: Container(
              height: size.getWidthPx(150),
              width: size.getWidthPx(170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          topRight: Radius.circular(2.0)),
                      child: Image.asset('assets/${property.image}',
                          fit: BoxFit.fill)),
                  SizedBox(height: size.getWidthPx(8)),
                  leftAlignText(
                      text: property.propertyName,
                      leftPadding: size.getWidthPx(8),
                      textColor: Colors.deepOrange,
                      fontSize: 14.0),
                  leftAlignText(
                      text: property.propertyLocation,
                      leftPadding: size.getWidthPx(8),
                      textColor: Colors.black54,
                      fontSize: 12.0),
                  SizedBox(height: size.getWidthPx(4)),
                  leftAlignText(
                      text: property.propertyPrice,
                      leftPadding: size.getWidthPx(8),
                      textColor: Colors.orange,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800),
                ],
              ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetailsPage(property, ['assets/feature_1.jpg','assets/feature_2.jpg','assets/feature_3.jpg'])));
          },
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


  Padding buildChoiceChip(index, chipName) {
    return Padding(
      padding: EdgeInsets.only(left: size.getWidthPx(8)),
      child: ChoiceChip(
        backgroundColor: backgroundColor,
        selectedColor: Colors.cyan,
        
        labelStyle: TextStyle(
            fontFamily: 'Exo2',
            color: (_selectedIndex == index) ? backgroundColor : textPrimaryColor,
        ),
          
        elevation: 4.0,
        padding: EdgeInsets.symmetric(
            vertical: size.getWidthPx(4), horizontal: size.getWidthPx(12)),
        selected: (_selectedIndex == index) ? true : false,
        label: Text(chipName),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              //_selectedIndex = index; // Uncomment this code to see effect
            });
          }
        },
      ),
    );
  }
}
