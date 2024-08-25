import 'package:bingo_game/firebase_options.dart';
import 'package:bingo_game/provider/host_provider.dart';
import 'package:bingo_game/screens/game_login.dart';
import 'package:bingo_game/screens/game_screen.dart';
import 'package:bingo_game/screens/home_page.dart';
import 'package:bingo_game/screens/host_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Bingo());
}

class Bingo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BingoState();
  }
}

class BingoState extends State<Bingo> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HostProvider(),
      child: MaterialApp(
        
        theme: ThemeData(
          textTheme: GoogleFonts.pressStart2pTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
          colorSchemeSeed: Colors.deepPurple, useMaterial3: true
            // primaryColor: Colors.purple.shade200
            ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
