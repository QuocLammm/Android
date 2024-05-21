import 'package:btl/bai_tap_lon/widget/radio_button.dart';
import 'package:btl/bai_tap_lon/widget/wrapper_data.dart';
import 'package:flutter/material.dart';
import 'package:btl/bai_tap_lon/login_out/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:btl/bai_tap_lon/widget/radio_button.dart';
import 'package:btl/bai_tap_lon/widget/wrapper_data.dart';
import 'package:flutter/material.dart';

class PageProfile extends StatelessWidget {
  const PageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(image: AssetImage("asset/images/1.jpg"),),
            ),
          ),
          SizedBox(height: 20,),
          Column(
            children: [
              Text("Tên người dùng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Email", style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow
              ),
              child: Text("Chỉnh sửa",style: TextStyle(color:Colors.black),),
            ),
          ),
          Divider(),
          SizedBox(height: 30,),
          ListTile(
            leading: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blueAccent,
              ),
              child: Icon(Icons.wallet, color: Colors.white),
            ),
            title: Text("Ví của tôi"),
            onTap: () {
              // ListTile action
            },
            trailing: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(Icons.keyboard_arrow_right_outlined,size: 30,),
            ),
          ),
          ListTile(
            leading: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blueAccent,
              ),
              child: Icon(Icons.shopping_bag_sharp, color: Colors.white),
            ),
            title: Text("Lịch sử mua hàng"),
            onTap: () {
              // ListTile action
            },
            trailing: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(Icons.keyboard_arrow_right_outlined,size: 30,),
            ),
          ),
          ListTile(
            leading: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blueAccent,
              ),
              child: Icon(Icons.settings, color: Colors.white),
            ),
            title: Text("Bảo mật"),
            onTap: () {
              // ListTile action
            },
            trailing: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(Icons.keyboard_arrow_right_outlined,size: 30,),
            ),
          ),
          SizedBox(height: 40,),
          SizedBox(
            width: 300,
            child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => PageLogin(),), (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.red, width: 2),
                  ),
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                ),
                child: Text("ĐĂNG XUẤT",style: TextStyle(
                    fontSize:20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                ),)),
          )
        ],
      ),
    );
    return const Placeholder();

  }
}





