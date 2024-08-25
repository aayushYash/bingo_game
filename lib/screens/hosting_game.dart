import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HostingGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HostingGameState();
  }
}

class HostingGameState extends State<HostingGame> {
  TextEditingController _roomName = TextEditingController();

  int roomSize = 2;

  int roomCode = 0;

  bool hosted = false;

  bool stateUpdated = false;

  String docId = '';

  List player = [];


  @override
  Widget build(BuildContext context) {

    if(hosted && docId.isNotEmpty && !stateUpdated){
      FirebaseFirestore.instance.collection('match').doc(docId).get().then((docSnap) {
          final data = docSnap.data() as Map<String, dynamic>;
          setState(() {
        player = data['players'];
        stateUpdated = true;
      });
        } );
      
    }

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
        body: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.purpleAccent.shade100,),
        
        width: 350,
        child: hosted ? Column(
          mainAxisSize: MainAxisSize.min,
          children: player.map((e) => Card(
            
            child: SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 10),
                child: Text(e,style: const TextStyle(color: Colors.purple),),
              ),
            ),)).toList()
          
        ,) : Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Host Room"),
            const SizedBox(height: 10,),
            const Divider(color: Colors.deepPurple,),
            const SizedBox(height: 10,),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _roomName,
              decoration: const InputDecoration(

                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 0.1)
                  ), labelText: "Room Name"),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text("Room Size: "),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: roomSize == 2
                        ? null
                        : () {
                            setState(() {
                              roomSize--;
                            });
                          },
                    icon: const Icon(Icons.remove)),
                Text("$roomSize"),
                IconButton(
                    onPressed: roomSize == 5
                        ? null
                        : () {
                            setState(() {
                              roomSize++;
                            });
                            print(roomSize);
                          },
                    icon: const Icon(Icons.add))
              ],
            ),
            TextButton(onPressed: (){

              int numb = 1000 + Random().nextInt(9999-1000+1);

              setState(() {
                roomCode = numb;
              });
              
              FirebaseFirestore.instance.collection('match').add({
                'players': ['Aayush'],
                'roomName': _roomName.text,
                'calledNumber': [],
                'lastCalledValue': 0,
                'winner': '',
                'matchStarted': false,
                'turn': 0,
                'roomCode': numb
              }).then((value) {
                setState(() {
                  docId = value.id;
                  hosted = true;
                });
              });
            }, child: const Text("Host"))
          ],

        ),
      ),
    ));
  }
}


// AlertDialog(
//                                   title: ,
//                                   content: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () => {},
//                                         child: Text("Host"))
//                                   ],
//                                 )

