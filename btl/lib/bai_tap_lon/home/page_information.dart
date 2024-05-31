import 'package:btl/bai_tap_lon/Update_history/history.dart';
import 'package:btl/bai_tap_lon/login_out/login.dart';
import 'package:btl/bai_tap_lon/payment/accept_payment.dart';
import 'package:btl/bai_tap_lon/security/baomat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import lớp lưu trữ giao dịch

class PageProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    String displayName = user != null ? _getUserDisplayName(user.email!) : "Tên người dùng";
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset("asset/images/1.jpg"),
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Text(
                displayName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                user != null ? user.email! : "Email",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Chỉnh sửa profile
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              child: Text(
                "Chỉnh sửa",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Divider(thickness: 1.5),
          SizedBox(height: 30),
          ListTile(
            leading: _buildIcon(Icons.wallet),
            title: Text("Ví của tôi"),
            onTap: () {
              // Xử lý ví của tôi
            },
            trailing: _buildTrailingIcon(),
          ),
          ListTile(
            leading: _buildIcon(Icons.shopping_bag_sharp),
            title: Text("Lịch sử mua hàng"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryShopping(
                    transactions: TransactionStore().getTransactions(), // Lấy danh sách giao dịch
                  ),
                ),
              );
            },
            trailing: _buildTrailingIcon(),
          ),
          ListTile(
            leading: _buildIcon(Icons.settings),
            title: Text("Bảo mật"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageSecurity(),
                ),
              );
            },

            trailing: _buildTrailingIcon(),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PageLogin()),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.red, width: 2),
                ),
                elevation: 0.0,
                shadowColor: Colors.transparent,
              ),
              child: Text(
                "ĐĂNG XUẤT",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIcon(IconData iconData) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blueAccent,
      ),
      child: Icon(iconData, color: Colors.white),
    );
  }

  Widget _buildTrailingIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Icon(Icons.keyboard_arrow_right_outlined, size: 30),
    );
  }

  String _getUserDisplayName(String email) {
    List<String> parts = email.split("@");
    String username = parts[0];
    String displayName = username.substring(0, 1).toUpperCase() + username.substring(1);
    return removeVietnameseAccent(displayName);
  }

  String removeVietnameseAccent(String str) {
    str = str.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    str = str.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    str = str.replaceAll(RegExp(r'[đ]'), 'd');
    return str;
  }
}
