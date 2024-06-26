import 'package:btl/bai_tap_lon/admin/page_qlkhohang.dart';
import 'package:btl/bai_tap_lon/login_out/login.dart';
import 'package:flutter/material.dart';

class PageHomeAdmin extends StatelessWidget {
  const PageHomeAdmin({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chủ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Xin chào ADMIN",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green), // Màu viền xanh
                  color: Colors.lightBlueAccent, // Nền xanh nhạt
                  borderRadius: BorderRadius.circular(10), // Bo tròn góc
                ),
                child: TextButton(
                  onPressed: () {
                     Navigator.push(context,MaterialPageRoute(builder: (context) => PageQuanLyKhoHang()),);
                  },
                  child: Text(
                    "Quản lý kho hàng",
                    style: TextStyle(fontSize: 18, color: Colors.white), // Chữ trắng
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue), // Màu viền xanh
                  color: Colors.lightBlueAccent, // Nền xanh nhạt
                  borderRadius: BorderRadius.circular(10), // Bo tròn góc
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => PageQuanLyBaoCao()),
                    // );
                  },
                  child: Text(
                    "Quản lý đơn hàng",
                    style: TextStyle(fontSize: 18, color: Colors.white), // Chữ trắng
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green), // Màu viền xanh
                  color: Colors.red, // Nền xanh nhạt
                  borderRadius: BorderRadius.circular(10), // Bo tròn góc
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageLogin()),
                    );
                  },
                  child: Text(
                    "Log out",
                    style: TextStyle(fontSize: 18, color: Colors.white), // Chữ trắng
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
