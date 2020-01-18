import 'package:clevercheckin/date_test2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateTest extends StatefulWidget {
final check;

DateTest(this.check);

  @override
  _DateTestState createState() => _DateTestState();
}

class _DateTestState extends State<DateTest> {
  
  var dope;
  

var list = [];
var all1;
 var all = ["F3ykiyZWiJJLntvskVRT",
"259uteWoX92fYKWc01FX",
"3zfuNFWdfSPnHK11X6N3",
"qQ67mtcTbhuy5dRKK0Kc",
"85e1d390-32cf-11ea-bbd9-fd6959a7eac2",
"b8b68590-32cf-11ea-bbd9-fd6959a7eac2",
"cb117740-32cf-11ea-bbd9-fd6959a7eac2",
"f243f360-32cf-11ea-bbd9-fd6959a7eac2",
"0e53f0f0-32d0-11ea-bbd9-fd6959a7eac2"];

/*  @override
  void initState()  {
    var all;
    super.initState();

    downprops().then(( QuerySnapshot docs)async{
      print(List<String>.from(docs.documents[0].data['allproperties']).runtimeType.toString() + '++++++++++++++++++++++++');
     all =  docs.documents[0].data['allproperties'];

     
    });
    print(all.toString() +'init');
  }  */

  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('datetest'),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('properties').where('1-1-20' , isGreaterThanOrEqualTo: []).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
           
            print(all1.toString() + 'dekh le');  
          print(widget.check.length.toString()+ 'check');
          print(snapshot.data.documents.length.toString() + 'snapshot');
          
          for (var docshot in snapshot.data.documents) {
            for (var item in widget.check) {
              print(item);
              print(docshot.data[item].toString());
              list =  list + docshot.data[item];
              print(list);
            }

             
          }
          print(all.toString() + '===================================' + list.length.toString());

          for (var item in list) {

            all.remove(item.toString());
          }
          return
          ListView.builder(
            itemCount: all.length,
            itemBuilder: ((context ,index){
              return ListBuilder(all[index]);
            }),
          );
           /* Column(
            children: <Widget>[
              for (var item in all) 
              Expanded(child: BookList(item))
            ],
          ); */
          
            
           
            
        }
      },
    )
    );
  }
}
    
class ListBuilder extends StatelessWidget {
  final item ;
  
  ListBuilder(this.item);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('individualproperties').document(item).snapshots(),
      builder: (BuildContext context,AsyncSnapshot snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
          print(snapshot.data['name']);
            return new ListTile(
              title: Text(snapshot.data['name'] ),
              subtitle: Text(snapshot.data['description']),
              
              onTap: (){
                print(item);
              },
              
            );
        }
      },
    );
  }
}

/* downprops(){
  return  Firestore.instance.collection('allproperties').getDocuments();
  
  } */

  /*  listall()async {
    var all;
    QuerySnapshot docs = await Firestore.instance.collection('allproperties').getDocuments();
    for (var item in docs.documents) {
      all = [] + item.data['allproperties'];
    }
    print(all.runtimeType.toString() + ' -----------------------');
    return List<String>.from(all);
  } */
 


/* import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DateTest extends StatefulWidget {
  @override
  _DateTestState createState() => _DateTestState();
}

class _DateTestState extends State<DateTest> {
List<String> check = ['5-1-20','6-1-20'];

var test;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data'),),
      body: StreamBuilder(
      stream: Firestore.instance.collection('properties').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        
        
        print(snapshot.data.documents.length);

        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return Column(
              children: <Widget>[
               for (var i = 0; i < 3 ; i++) 
                 listEquals((snapshot.data.documents[i].data['dates']), check)
                 //TRUE
                 ? Text(snapshot.data.documents[i].data['name'].toString() + ' not available')  
                 //FALSE 
                 : Text(snapshot.data.documents[i].data['name'.toString() ])
               
              ],
            );
            
            
            
        }
        
      },
    ));
      
      
    
  }
}

 */