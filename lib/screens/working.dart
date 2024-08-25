import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class Working extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
        SizedBox(
          height: 400,
          child: LottieBuilder.asset('assets/working.json')),
        const Text("Working on it!💻",),
        TextButton.icon(onPressed: () => Navigator.pop(context), icon: const FaIcon(FontAwesomeIcons.backward), label: const Text("Back"))
      ],)),
    );
  }
}