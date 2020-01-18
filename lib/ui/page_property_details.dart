import 'package:clevercheckin/widgets/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clevercheckin/widgets/widgets.dart';
import 'package:clevercheckin/model/models.dart';
import 'package:clevercheckin/utils/utils.dart';
import 'package:provider/provider.dart';

class PropertyDetailsPage extends StatefulWidget {
  final Property property;
  final List<String> propertyImagesList;
  String fromDateText = DateTime.now().add(Duration(days:1)).toString().substring(0,10),
      toDateText = DateTime.now().add(Duration(days:2)).toString().substring(0,10);
  PropertyDetailsPage(this.property, this.propertyImagesList);

  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  var temp;
  Set bookedDateSet = Set<String>();
  Map priceMap = Map<String,int>();
  @override
  Widget build(BuildContext context) {
      bookedDateSet.add(DateTime.now().add(Duration(days: 10)).toString().substring(0,10));
      return Material(
        child: Column(
          children: <Widget>[
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    pinned: true,
                    expandedHeight: 200.0,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: ccGradientDefault),
                      ),
                      child: FlexibleSpaceBar(
                        background: ImageSlider(widget.propertyImagesList),
                      ),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.white,),
                        tooltip: 'Share',
                        onPressed:
                        //TODO: Add share functionality
                        null,
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.white,),
                        tooltip: 'Mark as favorite',
                        onPressed:
                        //TODO: Add 'mark favorite' functionality,
                        null,
                      ),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate
                      (
                        [
                        DefaultTextStyle(
                          style: Styles.regularDarkTextStyle,
                          child: Container(
                            color: backgroundColor,
                            padding: EdgeInsets.fromLTRB(24, 20, 24, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //Property Type
                                GradientText("Bungalow".toUpperCase(),gradient: LinearGradient(colors: ccGradientPrimary),
                                    style: Styles.propertyTypeTextStyle),
                                Text(widget.property.propertyName,
                                    style: Styles.largeDarkTextStyle),
                                Text(widget.property.propertyLocation,
                                    style: Styles.regularDarkTitleTextStyle),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Property owner - Abc",
                                        style: Styles.regularDarkTitleTextStyle),
                                    IconButton(
                                      icon: Icon(Icons.account_circle, color: Colors.cyan,),
                                      onPressed: () {
                                        //TODO: Add redirection to host/owner page,
                                      },
                                    ),
                                  ],
                                ),
                                Divider(),
                                Text("Property Description",
                                    style: Styles.regularDarkTitleTextStyle),
                                Divider(),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Amenities",
                                        style: Styles.regularDarkTitleTextStyle),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("A/C"),
                                        Text("Internet"),
                                        Text("Essentials"),
                                        Text("24hr Water & Electricity"),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Column(
                                  children: <Widget>[
                                    Text("Location",
                                        style: Styles.regularDarkTitleTextStyle),
                                    //TODO: Add map view widget for location
                                  ],
                                ),
                                Divider(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Number of Guests',
                                          style: Styles.regularDarkTitleTextStyle),
                                      Text('10'),
                                    ]
                                ),
                                Divider(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Guest Bedrooms',
                                          style: Styles.regularDarkTitleTextStyle),
                                      Text('3'),
                                    ]
                                ),
                                Divider(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Beds for guests',
                                          style: Styles.regularDarkTitleTextStyle),
                                      Text('3'),
                                    ]
                                ),
                                Divider(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Bathrooms',
                                          style: Styles.regularDarkTitleTextStyle),
                                      Text('2'),
                                    ]
                                ),
                                Divider(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Swimming Pool',
                                          style: Styles.regularDarkTitleTextStyle),
                                      Text('Shared'),
                                    ]
                                ),
                                Divider(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Availability',
                                            style: Styles.regularDarkTitleTextStyle),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute<List<DateTime>>(builder: (context) => CalendarProvider(bookedDateSet, priceMap, false)));
                                            },
                                          icon: Icon(Icons.date_range, color: Colors.cyan,),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Contact host',
                                          style: Styles.regularDarkTitleTextStyle),
                                      GestureDetector(
                                          child: Text('Message'),
                                          onTap: () {} //TODO: Add read more functionality,
                                      ),
                                    ]
                                ),
                                //TODO: Add reviews & similar properties
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 2),
                        child: Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: <Widget>[
                            GradientText("\u20B910,000", gradient: LinearGradient(colors: ccGradientPrimary),style: Styles.boldDarkTitleTextStyle,),
                            Text("/weekend", style: Styles.subTextStyle,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 4),
                        child: Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,

                          children: <Widget>[
                            GradientText("\u20B98,000", gradient: LinearGradient(colors: ccGradientPrimary),style: Styles.boldDarkTitleTextStyle,),
                            Text("/weekday", style: Styles.subTextStyle,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Text(3.5.toString()),
                            Text("-"),
                            Text(200.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  RaisedGradientButton(
                    gradient: LinearGradient(
                      colors: ccGradientDefault,
                    ),
                    width: 150,
                    child: Text('Check Availability', style: Styles.regularLightTextStyle,),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute<List<DateTime>>(builder: (context) => CalendarProvider(bookedDateSet, priceMap, true,)));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}