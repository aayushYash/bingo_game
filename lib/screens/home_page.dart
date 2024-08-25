import 'package:bingo_game/screens/game_screen.dart';
import 'package:bingo_game/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("home")),
      body: MenuScreen(),
    );
  }
}