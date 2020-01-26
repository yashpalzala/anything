import 'package:clevercheckin/utils/colors.dart';
import 'package:clevercheckin/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateTest4 extends StatefulWidget {

final check;
  DateTest4(this.check);
  @override
  _DateTest4State createState() => _DateTest4State();
}

class _DateTest4State extends State<DateTest4> {
  var all = [];
  
  var list =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('date test 4'),),
      body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('allproperties').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            for (var item in snapshot.data.documents) {
              all = all + item.data['allproperties'];
            }
            print(all.runtimeType);
            print(all);
            
               return checker(all, widget.check, list);
             
             
            
        }
      },
    ),
    bottomNavigationBar: Row(
      children: <Widget>[
        FloatingActionButton(onPressed: (){
          addblocked('1-1-20');
        },),
        // Removes poperties from the blocked list
        FlatButton(child:Text('remove') ,onPressed: (){
           Firestore.instance.collection('properties').document('1-1-20').updateData({'blocked': FieldValue.arrayRemove(['whats'])}); 
        }),
      ],
    ),);
  }
}
// Add properties in the block list by passing the date and propert document id.
addblocked(date)async{
  
  DocumentSnapshot docref = await Firestore.instance.collection('properties').document(date).get();
  
    if(docref.data == null){
      Firestore.instance.collection('properties').document(date).setData({'blocked':[date]});
    }
    
  

    Firestore.instance.collection('properties').document(date).updateData({'blocked': FieldValue.arrayUnion(['whatss'])}); 
                
}

// checks all the blocked properties corresponding to all the available properties.

 Widget checker(all, check, list) {
  return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('properties').where('blocked' , arrayContainsAny:check /* ['1-1-2020','2-1-2020','5-1-2020'] */).snapshots(), // only required snapshots are called
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
           print(all.toString()+'in checker');
              print(check);
          print(check.length.toString()+ 'check');
          print(snapshot.data.documents.length.toString() + '----snapshot - docs'); // this prints no. of snapshots called
          print(snapshot.data.documents[0].data);
          
          for (var docshot in snapshot.data.documents) {
            for (var item in check) {
              print(item);
              print(docshot.data['blocked'].toString() + '====================');
              list =  list + docshot.data['blocked'];
              
            }
              
             
          }
          print(list.toString() + '---------------');

          for (var item in list) {
            print('removed' + item);
            all.remove(item);
            
          }

          print(all.toString() + '+++++++++++++++++');
          return
          ListView.builder(
            itemCount: all.length,
            itemBuilder: ((context ,index){
              return  ListBuilder(all[index]); 
            }),
          );
}
      },
    );
} 
      
// Builds a list view of the available properties . Requires property document id as an argument
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
            return Stack(
              children: <Widget>[
                Padding(
              padding: const EdgeInsets.all(14),
              child: InkWell( onTap:(){print(item);} ,
                              child: Container(
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    
                  ),
                  
                  child: new ClipRRect(
    borderRadius: new BorderRadius.circular(8.0),
    
    child: Image.network(
        snapshot.data['picture'],
        height: 200.0,
        width: 350.0,
        fit: BoxFit.fill,
    ),
),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container( decoration: BoxDecoration(
                color: Colors.cyan[300],
                borderRadius: BorderRadius.circular(18)

                
              ),
              
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.data['name'] , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, 
                  fontStyle: FontStyle.italic, color: Colors.white),),
                ),
              ),
            )
              ],
            );
            
             /* ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data['picture'])),
              title: Text(snapshot.data['name'] ),
              subtitle: Text(snapshot.data['description']),
              
              onTap: (){
                print(item);
              },
              
            ); */ 
        }
      },
    );
  }
}
    

