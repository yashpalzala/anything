import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clevercheckin/ui/photo_list.dart';
import 'package:clevercheckin/utils/utils.dart';
import 'package:clevercheckin/widgets/utils_widget.dart';
import 'package:clevercheckin/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Screen size;

  /* Variables and methods for form */
  List<String> _types = ['Villa', 'Bungalow', 'House'];
  String _selectedType;

  List<String> _swmng_pool_type = ['Private', 'Shared', 'No Swimming Pool'];
  String _selectedSwmngPool;
  

  bool kitchen = true;

  int _guests = 10;
  int _bedrooms = 4;
  int _beds = 4;
  int _baths = 3;

  void add_guests() {
    setState(() {
      _guests++;
    });
  }
  void sub_guests() {
    setState(() {
      if (_guests != 0) 
        _guests--;
    });
  }
  void add_bedrooms() {
    setState(() {
      _bedrooms++;
    });
  }
  void sub_bedrooms() {
    setState(() {
      if (_bedrooms != 0) 
        _bedrooms--;
    });
  }
  void add_beds() {
    setState(() {
      _beds++;
    });
  }
  void sub_beds() {
    setState(() {
      if (_beds != 0) 
        _beds--;
    });
  }
  void add_baths() {
    setState(() {
      _baths++;
    });
  }
  void sub_baths() {
    setState(() {
      if (_baths != 0) 
        _baths--;
    });
  }
  void uploadImages(){}

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: backgroundColor),
        child: Container(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: <Widget>[upperPart()],
            ),
          ),
        ),
      ),
    );
  }

  Widget upperPart() {
    return Stack(children: <Widget>[
      ClipPath(
        clipper: UpperClipper(),
        child: Container(
          height: size.getWidthPx(150),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 5, 138, 255), Color.fromARGB(255, 50, 250, 213)],
            ),
          ),
        ),
      ),
      Column(
        children: <Widget>[
          profileWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              followersWidget(),
              nameWidget(),
              likeWidget(),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.getWidthPx(8),
                left: size.getWidthPx(20),
                right: size.getWidthPx(20)),
            child: Container(height: size.getWidthPx(4), color: colorCurve),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //buttonWidget("Follow "),
              //buttonWidget("Chat"),
            ],
          ),

          // PhotosList()
          

          Container(
            height: 520,
            
            padding: new EdgeInsets.all(20.0),
            margin: new EdgeInsets.all(8.0),
            child: new Form(
              
              key: this._formKey,              
              child: new ListView(
                 physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  new Text('Some photos of your property', style: TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    child: OutlineButton(
                      onPressed: uploadImages,
                      child: Text('Select Photos'),
                    ),
                    margin: new EdgeInsets.only(
                      top:10.0,
                      bottom: 16.0
                    ),
                  ),

                  new Text('About your place', style: TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Villa or Bungalow or a House?'),
                      value: _selectedType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedType = newValue;
                        });
                      },
                      items: _types.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                    margin: new EdgeInsets.only(
                      bottom: 16.0
                    ),
                  ),
                  new Text('Number of guests', style: TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    child: new Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new FloatingActionButton(
                            onPressed: sub_guests,
                            child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
                            backgroundColor: Colors.white,
                          ),
                          new Text('$_guests'),
                          new FloatingActionButton(
                            onPressed: add_guests,
                            child: new Icon(Icons.add, color: Colors.black,),
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),  
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0,
                      bottom:16.0
                    ),
                  ),
                  new Text('Guest bedrooms', style: TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    child: new Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new FloatingActionButton(
                            onPressed: sub_bedrooms,
                            child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
                            backgroundColor: Colors.white,
                          ),
                          new Text('$_bedrooms'),
                          new FloatingActionButton(
                            onPressed: add_bedrooms,
                            child: new Icon(Icons.add, color: Colors.black,),
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),  
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0,
                      bottom: 16.0
                    ),
                  ),
                  new Text('Beds for guests', style: TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    child: new Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new FloatingActionButton(
                            onPressed: sub_beds,
                            child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
                            backgroundColor: Colors.white,
                          ),
                          new Text('$_beds'),
                          new FloatingActionButton(
                            onPressed: add_beds,
                            child: new Icon(Icons.add, color: Colors.black,),
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),  
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0,
                      bottom:16.0
                    ),
                  ),
                  new Text('Bathrooms', style: TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    child: new Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new FloatingActionButton(
                            onPressed: sub_baths,
                            child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
                            backgroundColor: Colors.white,
                          ),
                          new Text('$_baths'),
                          new FloatingActionButton(
                            onPressed: add_baths,
                            child: new Icon(Icons.add, color: Colors.black,),
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),  
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0,
                      bottom:16.0
                    ),
                  ),       
                  new Text('Swimming Pool', style: TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Swimming Pool'),
                      value: _selectedSwmngPool,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSwmngPool = newValue;
                        });
                      },
                      items: _swmng_pool_type.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0, bottom: 16.0
                    ),
                  ),

                  new Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    child: new TextFormField(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        hintText: 'House No., Locality/Building Name',
                        labelText: 'House No., Locality/Building Name',
                        labelStyle: TextStyle(color: Colors.black87)          
                      )
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0
                    ),
                  ),
                  new Container(
                    child: new TextFormField(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        hintText: 'Road Name, Area, Colony',
                        labelText: 'Road Name, Area, Colony',
                        labelStyle: TextStyle(color: Colors.black87)          
                      )
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0
                    ),
                  ),
                  new Container(
                    child: new TextFormField(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        hintText: 'City',
                        labelText: 'City',
                        labelStyle: TextStyle(color: Colors.black87)          
                      )
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0
                    ),
                  ),
                  new Container(
                    child: new TextFormField(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        hintText: 'State',
                        labelText: 'State',
                        labelStyle: TextStyle(color: Colors.black87)          
                      )
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0
                    ),
                  ),
                  new Container(
                    child: new TextFormField(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        hintText: 'Pincode',
                        labelText: 'Pincode',
                        labelStyle: TextStyle(color: Colors.black87)          
                      )
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0,
                      bottom: 16.0
                    ),
                  ),
                  new Text('Other Amenities', style: TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    child: new TextFormField(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        hintText: 'Wifi, Kitchen, TV, Hot Water, Heating, Air Conditioning, Dryer, Iron, etc',
                        labelText: 'Amenities',
                        labelStyle: TextStyle(color: Colors.black87)          
                      )
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0
                    ),
                  ),
                  
                  Container(
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
                            Text(' Finish ', style: TextStyle(fontFamily: 'Exo2',color: Colors.white, fontSize: 20.0))
                          ],
                      ),
                      gradient: LinearGradient(
                        colors: ccGradientPrimary,
                      ),
                      onPressed: (){
                        //_validateInputs();
                      }
                    ),
                  ) 

                ],            
              ),
            )
          ),

        ],
      )
    ]);
  }

  GestureDetector followerAvatarWidget(String assetIcon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: size.getWidthPx(24),
        backgroundColor: Colors.transparent,
        child: Image.asset(assetIcon),
      ),
    );
  }

  /*Container buttonWidget(text) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(4), horizontal: size.getWidthPx(12)),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(22.0)),
        padding: EdgeInsets.all(size.getWidthPx(2)),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 14.0),
        ),
        color: colorCurve,
        onPressed: () {},
      ),
    );
  }*/

  Align profileWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: size.getWidthPx(60)),
        child: CircleAvatar(
          foregroundColor: backgroundColor,
          maxRadius: size.getWidthPx(50),
          backgroundColor: Colors.white,
          child: CircleAvatar(
            maxRadius: size.getWidthPx(48),
            foregroundColor: colorCurve,
            backgroundImage: NetworkImage(
                'https://avatars3.githubusercontent.com/u/17440971?s=400&u=b0d8df93a2e45812e577358cd66849e9d7cf0f90&v=4'),
          ),
        ),
      ),
    );
  }

  Column likeWidget() {
    return Column(
      children: <Widget>[
        Text("2",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 16.0,
                color: textSecondary54,
                fontWeight: FontWeight.w700)),
        SizedBox(height: size.getWidthPx(4)),
        Text("Properties",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 14.0,
                color: textSecondary54,
                fontWeight: FontWeight.w500))
      ],
    );
  }

  Column nameWidget() {
    return Column(
      children: <Widget>[
        Text("Rahul Patil",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 16.0,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w700)),
        SizedBox(height: size.getWidthPx(4)),
        Text("Host & Holiday Planner",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 14.0,
                color: textSecondary54,
                fontWeight: FontWeight.w500))
      ],
    );
  }

  Column followersWidget() {
    return Column(
      children: <Widget>[
        Text("5k",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 16.0,
                color: textSecondary54,
                fontWeight: FontWeight.w700)),
        SizedBox(height: size.getWidthPx(4)),
        Text("Views",
            style: TextStyle(
                fontFamily: "Exo2",
                fontSize: 14.0,
                color: textSecondary54,
                fontWeight: FontWeight.w500))
      ],
    );
  }

}
