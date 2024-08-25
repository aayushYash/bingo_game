import 'package:flutter/material.dart';

class HostProvider extends ChangeNotifier{
  var host;
  HostProvider({this.host});

  updateHost({required bool isHost}) async{
    host = isHost;
    notifyListeners();
  }

}