import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GameLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameLoginState();
  }
}

class GameLoginState extends State<GameLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent.shade100,
      body: Container(
          child: Stack(
        children: [
          Positioned(
            left: 10,
            right: 10,
            top: 140,
            child: Container(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                WavyAnimatedText(
                  'B I N G O',
                  textAlign: TextAlign.center,
                  textStyle:
                      const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, ),
                )
              ]),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            right: 10,
            child: Container(
              margin: const EdgeInsets.all(12),
              height: 500,
              // width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Transform.translate(
                    offset: const Offset(-25, 0),
                    child: Transform(
                      transform: Matrix4.skew(0.4, -0.1),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.purpleAccent,
                                    blurRadius: 5,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 2)
                              ]),
                          height: 150,
                          child: Image.asset('assets/bingoBoard.png')),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'LOGIN TO GAME',
                      style: TextStyle(color: Colors.purpleAccent),
                    ),
                  ),
                  Container(
                    child: Column(children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                            final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                            final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth?.accessToken,
                              idToken: googleAuth?.idToken
                            );

                            FirebaseAuth.instance.signInWithCredential(credential).then((value) => print("user name ::::::::::: ::::: :F::: :::::${value.user!.displayName}"));


                          },
                          icon: const FaIcon(FontAwesomeIcons.google),
                          label: const Text(
                            'Continue With Google',
                            style: TextStyle(fontSize: 10),
                          )),
                      ElevatedButton.icon(
                          onPressed: () async {
                            final GoogleSignInAccount? googleUser = await GoogleSignIn(
                              signInOption: SignInOption.games
                            ).signIn();
                            final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                            final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth?.accessToken,
                              idToken: googleAuth?.idToken
                            );

                            FirebaseAuth.instance.signInWithCredential(credential);


                          },
                          icon: const FaIcon(FontAwesomeIcons.googlePlay),
                          label: const Text(
                            'Continue with Google Play',
                            style: TextStyle(fontSize: 10),
                          ))
                    ]),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
