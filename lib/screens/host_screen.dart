import 'package:bingo_game/screens/hosting_game.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HostScreenState();
  }
}

class HostScreenState extends State<HostScreen> {
  String matchType = 'private';
  bool selected = true;
  // int roomSize = 2;

  final TextEditingController _roomName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () => {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Rooms'),
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Card(
                                            child: ListTile(
                                                title: const Text("Room Name"),
                                                subtitle: const Text("Host name"),
                                                trailing: TextButton(
                                                  child: const Text("Join"),
                                                  onPressed: () => {},
                                                )),
                                          )
                                        ]),
                                  ))
                        },
                    icon: const Icon(Icons.play_circle_fill),
                    label: const Text("Join Room")),
                ElevatedButton.icon(
                    onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HostingGame()))
                        },
                    icon: const FaIcon(FontAwesomeIcons.plus),
                    label: const Text("Host Room")),
              ]),
        ),
      ),
    );
  }
}
