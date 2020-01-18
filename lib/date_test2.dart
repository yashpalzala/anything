import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';


class DateTest2 extends StatefulWidget {
  @override
  _DateTest2State createState() => _DateTest2State();
}

class _DateTest2State extends State<DateTest2> {
 /*  var all = ["F3ykiyZWiJJLntvskVRT",
"259uteWoX92fYKWc01FX",
"3zfuNFWdfSPnHK11X6N3",
"qQ67mtcTbhuy5dRKK0Kc",
"85e1d390-32cf-11ea-bbd9-fd6959a7eac2",
"b8b68590-32cf-11ea-bbd9-fd6959a7eac2",
"cb117740-32cf-11ea-bbd9-fd6959a7eac2",
"f243f360-32cf-11ea-bbd9-fd6959a7eac2",
"0e53f0f0-32d0-11ea-bbd9-fd6959a7eac2"]; */
  var all;

  var checks = ['1-1-20','2-1-20'] ;
  var list;
  var uuid = Uuid();
  @override
  void initState()  {
    downprops().then(( QuerySnapshot docs)async{
      print(List<String>.from(docs.documents[0].data['allproperties']).runtimeType);
     all =  docs.documents[0].data['allproperties'];

     
    });
    print(all .toString() +'init');
    super.initState();
  } 
  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(title: Text('data'),),
          body: Column(
            children: <Widget>[
                FloatingActionButton(onPressed: ()async{ 
                 
                  
                
                  
                for (var item in checks) {
                  
                  await list.add( reviewServices(item));
                }
                print(list.toString() + ' list bana kya?');
               
                /* if(docs.documents.isNotEmpty){
                   
                      print(docs.documents[0].data['datesmap']['9-1-20'].runtimeType);
                      print(docs.documents.length);
                       list = docs.documents[0].data['datesmap']['9-1-20'];
                      print('list : '+ list.toString());

                }
                if(docs.documents.isEmpty){
                  print('empty');
                } */
                print(all.toString() +'andar');  
              
              all = remove(all, list);
                print(all.toString() + 'remove vala all');
              }
              
              ),  
              /* FlatButton(child: Text('remove'),onPressed: (){
               
                
              },), */

              /* FlatButton(child: Text('show'),onPressed: (){
                show(all);
              },), */
              FlatButton(child: Text('block'), onPressed: (){
                addblocked();
              },)

              /* FloatingActionButton(onPressed: tran(),), */

              

                /* FloatingActionButton(
                 child: Icon(Icons.add_circle),onPressed: ()async{
                 var id = uuid.v1();
                 Firestore.instance.collection('individualproperties').document(id)
                  .setData({ 'name': 'bangalore', 'description': 'anything' });

                DocumentReference docref = Firestore.instance.collection('allproperties').document('all');
                DocumentSnapshot doc = await docref.get();
                var props = doc.data['allproperties'];
                addprops(docref, props, id);
                
              },) */ 
            ],
          )
          
          
          /*  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('properties').snapshots(),
        builder: (BuildContext context,  snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
            
              return Column(
                children: <Widget>[
                 for (var i = 0; i <= 2 ; i++) 
                  testcase(List<String>.from(snapshot.data.documents[i].data['dates']), check) ? null :  Text(snapshot.data.documents[i].data['name'])
                   /* listEquals(List<String>.from(snapshot.data.documents[i].data['dates']), check)
                   //TRUE
                   ? Text(snapshot.data.documents[i].data['name'].toString() + ' not available')  
                   //FALSE 
                   : Text(snapshot.data.documents[i].data['name'.toString() ])  */
                 
                ],
              );
          }
        },
      ), */
    );
  }
}

addblocked()async{
   Firestore.instance.collection('properties').document('1').updateData({'1-1-20': FieldValue.arrayUnion(['0e53f0f0-32d0-11ea-bbd9-fd6959a7eac2'])});
                
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
  
    




    
  

  addates(dates, docref){
     
      docref.updateData({
        'dates' : FieldValue.arrayUnion(['bhopal'])
      
      }); 
  }

tran(){
  final DocumentReference postRef = Firestore.instance.collection('properties').document('mumbai');
Firestore.instance.runTransaction((Transaction tx) async {
  DocumentSnapshot postSnapshot = await tx.get(postRef);
  if (postSnapshot.exists) {
    await tx.update(postRef, <String, dynamic>{'datesmap.10-2-20': postSnapshot.data['datesmap']['10-2-20'] +['kolkata']});
  }
});
}



  addprops(docref, props, id){
    docref.updateData({
        'allproperties' : FieldValue.arrayUnion([id])
      
      });
  }

  remove(all, list){
    var all1 = all.toList();
    for (var item in list) {
      all1.remove(item);
    
    }
    show(all1);

    return all1;
  }

show(all) async{
  print(all.runtimeType);
  print(all);
  for (var item in all) {
    DocumentSnapshot doc = await Firestore.instance.collection('individualproperties').document(item).get();
    print(doc.data['name']);
  }
  

}

downprops(){
  return  Firestore.instance.collection('allproperties').getDocuments();
  
  }


/* bool testcase (list,check){
    bool available = false;
  int j =0 ;
 while ( j<=1 ) {
   
   available = true;
   j++;
   print(list[j]);
 } 
 
 
 return available; 
//return Text(list[0]+list[1] + check[0] + check[1] + 'checklength = ' + list.length.toString());

} */