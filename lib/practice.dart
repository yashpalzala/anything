import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

import 'dart_test4.dart';

class Practice extends StatefulWidget {
  @override
  _PracticeState createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  DateTime picked1;
  var i=0;
  List dates = [];

  final DateFormat dateformat = DateFormat.yMd();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DatePicker'),),
      body: new MaterialButton(
    color: Colors.deepOrangeAccent,
    onPressed: () async {
      dates= [];
      final List<DateTime> picked = await DateRagePicker.showDatePicker(
          context: context,
          initialFirstDate: new DateTime.now(),
          initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
          firstDate: new DateTime(2015),
          lastDate: new DateTime(2021)
      );
      if (picked != null && picked.length == 2) {
        print(picked.toString() + 'whattt');
        print(picked[0]== picked[1]);
        print(picked[1].day);

        /* ates.add(picked[0]); */
        for (var i = 0; !picked[0].isAtSameMomentAs(picked[1].add(Duration(days:1))) ; i++) {
          
          dates.add('${picked[0].day}-${picked[0].month}-${picked[0].year}');
          print(picked[0]);
         picked[0] = picked[0].add(Duration(days: 1));
          
          
        }
        dates = List<String>.from(dates);
        print(dates);
        print(dates.runtimeType);
        
        
        
        
         
      }
    },
    child: new Text("Pick date range")
),
bottomNavigationBar: FloatingActionButton(child: Icon(Icons.navigate_next),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  DateTest4(dates)  ));},),
      
    );
  }
}
















/* import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Practice extends StatefulWidget {
  @override
  _PracticeState createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  var word = 'hello';

  dosomething(){
  setState(() {
    if(word == 'hello'){word = 'bye';}
    else{ word = 'hello';}
    
  });
}

caller(){
  dosomething();
}

Future display() async {
  
  var data = await http.get('http://www.json-generator.com/api/json/get/bUayTgaPyq?indent=2');
  var jsonData = json.decode(data.body);
  List users = [];
  for (var u in jsonData) {
    User user = User(u['company'],u['email'], u['picture']);
    
    users.add(user);
  }
  print(users.length);
   
  return users;
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practice'),),
      body: FutureBuilder(
        future: display(),
        builder: (context, AsyncSnapshot snap){
          if(snap.data == null){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
              itemCount: snap.data.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(snap.data[index].picture),),
                title: Text(snap.data[index].company),
                onTap: (){},
              );
            },
            
          );
          }
          
        },
        ),
      
      bottomNavigationBar: Text(word),
      floatingActionButton: FloatingActionButton(onPressed: (){display();},),
      
    );
  }
}


class User{
  final company;
  final email;
  final picture;
  User(this.company,this.email, this.picture);
  
} */