import 'package:bingo_game/screens/host_screen.dart';
import 'package:bingo_game/screens/working.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class MenuScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent.withAlpha(30),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        TextButton.icon(icon: const FaIcon(FontAwesomeIcons.chessBoard) , onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Working()));
        }, label: const Text('Create Board')),
        TextButton.icon(icon:const FaIcon(FontAwesomeIcons.server),onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HostScreen()));
        }, label: const Text("Play Online")),
        TextButton.icon(icon: const FaIcon(FontAwesomeIcons.gear), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Working()));
        }, label: const Text("Settings"),)
        
      ],)),
    );
  }
}