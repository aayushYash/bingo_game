import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameScreenState();
  }
}

class GameScreenState extends State<GameScreen> {
  List calledNumbers = [];
  callFirebaseNumber(n) {
    FirebaseFirestore.instance.collection('match').doc('match1').update({
      'lastCalledValue': n,
      'called': FieldValue.arrayUnion([n]),
    });
  }

  List board = List<List>.generate(5, (i) => List<int>.generate(5,(index) => -1));

  // List card = List.generate(
  //     5, (_) => List.filled(5, {'called': true, 'value': -1}),
  //     growable: true);

  List card = List.filled(
      25,
      -1,
      growable: true);
  int number = 1;
  bool ready = false;
  int calledNumlength = 1;

  // List bingo = ['B', 'I', 'N', 'G', 'O'];
  List rows = [0, 1, 2, 3, 4];
  List cols = [0, 1, 2, 3, 4];

  int bingo = 0;
  String msg = "";

  String gameMessage = '';

  void gameReset(){
    FirebaseFirestore.instance.collection('match').doc('match1').update({
      'called': [],
      'lastCalledValue': 0,
    });
    setState(() {
      bingo = 0;
      card.clear();
      card = List.generate(25, (index) => -1);
      board.clear();
      board = List<List>.generate(5, (index) => List<int>.generate(5, (i) => -1));
      number = 1;
      ready = false;
    });
  }

  void updateState(){
    setState(() {
      calledNumlength = calledNumbers.length;
    });
  }

  bool checkRow(row){
    for(int col = 0 ;col<5;col++){
      if(!calledNumbers.contains(board[row][col])) return false;
    }
    return true;
  }

  bool checkCol(col){

    for(int row = 0 ;row<5;row++){
      if(!calledNumbers.contains(board[row][col])) return false;
    }
    return true;
  }

  bool leftDiagonal(){
    int i=0,j=0;
    while(i < 5){
      if(!calledNumbers.contains(board[i][j])) return false;
      i++;
      j++;
    }
    return true;
  }
  bool rightDiagonal(){
    int i=4,j=0;
    while(i > -1){
      if(!calledNumbers.contains(board[i][j])) return false;
      i--;
      j++;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    final docRef = FirebaseFirestore.instance.collection("match").doc("match1");
      // int index;
      docRef.snapshots().listen(
      (event) {
        if(calledNumlength != event.data()!['called'].length){
          calledNumbers = event.data()!['called'];
          int index = card.indexOf(event.data()!['lastCalledValue']);
          int row = index~/5;
          int col = index%5;

          setState(() {
            if(checkCol(col)) bingo++;
            if(checkRow(row)) bingo++;
            if(row == col)
              if(leftDiagonal()) bingo++;
            if(row+col == 4)
              if(rightDiagonal()) bingo++;
            // if(bingo > 0) msg = ;
            if(bingo == 5){
              showDialog(context: context, builder: (context) => AlertDialog(title: Text("You Won"),actions: [
                TextButton(onPressed: (){
                  gameReset();
                  Navigator.pop(context);
                }, child: Text("OK"))
              ],));
            }
            // if(checkCol(col) || checkRow(row) || leftDiagonal() || rightDiagonal()) bingo++;
            calledNumlength = event.data()!['called'].length;
          },);
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(gameMessage),
            ),
          ),
      
          Center(
            child: Text(bingo > 0 ? "BINGO".substring(0,bingo > 5 ? 5: bingo) : ''),
          ),
          // player's board
      
          Expanded(
            child: GridView.builder(
              itemCount: card.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5),
              itemBuilder: (context, index) {
                bool called = calledNumbers.contains(card[index]);
                return Card(
                  color: called ? Colors.purple.shade300 : Colors.purple.shade100,
                  child: InkWell(
                    onTap: card[index] < 0
                        ? () {
                            int row = index~/5;
                            int col = index%5;
                            setState(() {
                              card[index] = number;
                              board[row][col] = number;
                              number++;
                            });
                          }
                        : !called && ready
                            ? () => {
                              callFirebaseNumber(card[index])
                            }
                            : null,
                    child: Center(
                        child: Text(
                      card[index] == -1
                          ? ''
                          : card[index].toString(),
                      style: TextStyle(
                          decoration: called ? TextDecoration.lineThrough : null),
                    )),
                  ),
                );
              },
            ),
          ),
      
      
          // Footer
      
          if(!ready) Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      number = 1;
                      card.clear();
                      card = List.filled(
                          25,
                          -1,
                          growable: true);
                    });
                  },
                  icon: const FaIcon(FontAwesomeIcons.rotate),
                  label: const Text("Reset")),
                  TextButton(
                  onPressed: () {
                    // int i=1;
                    setState(() {
                      number = 26;
                      card.clear();
                      card = List.generate(
                          25,
                          (i) => i+1,
                          growable: true);
                      card.shuffle();
                      for(int i=0;i<25;i++){
                        board[i~/5][i%5] = card[i];
                      }
                    });
                  },
                  child: const Text("Auto Fill")),
                 
              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            TextButton.icon(
                  onPressed: number <= 25
                      ? null
                      : () {
                        setState(() {
                          ready = true;
                        });
                        // Timer.periodic(Duration(seconds: 1),(timer){
                        //   setState(() {
                            
                        //   });
                        // });
                      },
                  icon: const FaIcon(FontAwesomeIcons.gamepad),
                  label: const Text("Ready")),
                  TextButton(
                  onPressed: gameReset,
                  child: const Text("New Game"))
          ],)
        ]),
      ),
    );
  }
}
