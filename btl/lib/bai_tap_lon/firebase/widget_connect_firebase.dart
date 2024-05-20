import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:btl/firebase_options.dart';


class MyFirebaseConnect extends StatefulWidget {
  final String errorMessage;
  final String connectingMessage;
  final Widget Function(BuildContext context) builder;
  const MyFirebaseConnect({Key? key,
    required this.errorMessage,
    required this.connectingMessage,
    required this.builder});

  @override
  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool ketNoi = false;
  bool loi = false;
  @override
  Widget build(BuildContext context) {
    if(loi){
      return
        Container(
          color: Colors.white,
          child: Center(
            child: Text(widget.errorMessage,
              style: TextStyle(fontSize: 16, color: Colors.blue ),
              textDirection: TextDirection.ltr,
            ),
          ),
        );
    } else
    if(ketNoi==false){
      return
        Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text(widget.connectingMessage,
                  style: TextStyle(fontSize: 16),
                  textDirection: TextDirection.ltr,
                )
              ],
            ),
          ),
        );
    } else{
      return
        widget.builder(context);
    }
  }
  @override
  void initState(){
    super.initState();
    _khoitaoFireBase();
  }

  _khoitaoFireBase(){
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .then((value){
      setState(() {
        ketNoi = true;
      });
    }
    ).catchError((Error){
      setState(() {
        loi = true;
      });
    }).whenComplete(() {
      print("Hoàn tất kết nối FireBase!");
    });
  }
}