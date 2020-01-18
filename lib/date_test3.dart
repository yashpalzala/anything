import 'package:clevercheckin/date_test2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';



class DateTest3 extends StatefulWidget {

  
  @override
  _DateTest3State createState() => _DateTest3State();
}

class _DateTest3State extends State<DateTest3> {

  var all = ["F3ykiyZWiJJLntvskVRT",
"259uteWoX92fYKWc01FX",
"3zfuNFWdfSPnHK11X6N3",
"qQ67mtcTbhuy5dRKK0Kc",
"85e1d390-32cf-11ea-bbd9-fd6959a7eac2",
"b8b68590-32cf-11ea-bbd9-fd6959a7eac2",
"cb117740-32cf-11ea-bbd9-fd6959a7eac2",
"f243f360-32cf-11ea-bbd9-fd6959a7eac2",
"0e53f0f0-32d0-11ea-bbd9-fd6959a7eac2"];

  var checks = ['1-1-20','2-1-20'] ;
 var list =[] ;
 var newlist = ['loading...'];
 bool loading;
 @override
 void initState() {
   loading = true;
   depender();
    super.initState();
  }
 
 depender()async{
   list = await helper(checks, list, all, loading);
 }  

Future<List<dynamic>> remove(all, list)async {
    var all1 = all.toList();
    for (var item in list) {
      all1.remove(item);
    
    }
    setState(() {
      loading = false;
      print(loading);
       newlist = List<String>.from(all);
    });
  
    return all1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('datetest3'),),
      body: Text(newlist.toString())
        
      
      
    );
  }
}

helper(checks,list,all, loading)async{
  for (var item in checks) {
   
  list = list +  List<String>.from(await reviewServices(item));
  
  
}
print(list.toString().toString() + '---------------------------------');
print(remove(all, list).toString() + '+++++++++++++++++++++++++++++');
return list;
}

Future<List> reviewServices(check)async{
  
  var list1;
  
    QuerySnapshot docs = await Firestore.instance.collection('properties').where(check.toString() , isGreaterThanOrEqualTo: []).getDocuments();
    if(docs.documents.isNotEmpty){
                 print(check);
                    print(docs.documents[0].data[check]);
                    print(docs.documents[0].data[check].runtimeType); 
                  list1 = docs.documents[0].data[check];
                }
                else
                print('empty');

                return list1 ;
  }

  