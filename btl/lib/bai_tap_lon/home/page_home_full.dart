import 'package:btl/bai_tap_lon/firebase/widget_connect_firebase.dart';
import 'package:btl/bai_tap_lon/home/page_home_coffe.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';



class PageHomeCoffe extends StatelessWidget {
  const PageHomeCoffe({super.key});

  @override
  Widget build(BuildContext context) {

    return MyFirebaseConnect(
      errorMessage: "Lỗi kết nối FireBase",
      connectingMessage: "Đang kết nối....",
      builder: (context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //initialBinding: (),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: PageHomeCf(),
      ),
    );
  }
}