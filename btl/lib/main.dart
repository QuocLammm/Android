import 'package:btl/bai_tap_lon/firebase/widget_connect_firebase.dart';
import 'package:btl/bai_tap_lon/home/page_home_full.dart';
import 'package:btl/bai_tap_lon/login_out/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      errorMessage: "Lỗi kết nối FireBase",
      connectingMessage: "Đang kết nối....",
      builder: (context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PageLogin(),
      ),
    );
  }
}

