import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageSecurity extends StatelessWidget {
  const PageSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtPassword = TextEditingController();
    TextEditingController txtNewPassword = TextEditingController();
    TextEditingController txtConfirmPassword = TextEditingController();
    Future<void> _changePassword(String currentPassword, String newPassword) async {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(newPassword);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Thành công"),
                content: Text("Đã thay đổi mật khẩu thành công"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Đóng"),
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        // Thông báo lỗi
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Lỗi"),
              content: Text("Nhập sai mật khẩu hiện tại!"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Đóng"),
                ),
              ],
            );
          },
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Thay đổi mật khẩu"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: txtPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.purple),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  labelText: "Mật khẩu hiện tại",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Icons.lock_outline),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15)
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtNewPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.purple),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  labelText: "Mật khẩu mới",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Icons.lock_outline),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15)
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: txtConfirmPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.purple),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  labelText: "Xác nhận mật khẩu mới",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Icons.lock_outline),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15)
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String currentPassword = txtPassword.text;
                String newPassword = txtNewPassword.text;
                String confirmPassword = txtConfirmPassword.text;
                try {
                  // Kiểm tra xác nhận mật khẩu mới
                  if (newPassword != confirmPassword) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Lỗi"),
                          content: Text("Mật khẩu mới không khớp. Vui lòng nhập lại."),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Đóng"),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  // Thực hiện thay đổi mật khẩu
                  await _changePassword(currentPassword, newPassword);
                } catch (error) {
                  print("Đã xảy ra lỗi: $error");
                }
              },
              child: Text("Thay đổi mật khẩu"),
            ),
          ],
        ),
      ),
    );
  }
}
