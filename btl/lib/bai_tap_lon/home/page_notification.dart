import 'package:flutter/material.dart';

class PageNotification extends StatelessWidget {
  final String userName;

  const PageNotification({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông báo"),
      ),
      body: ListView(
        children: [
          if (userName.isNotEmpty) // Chỉ hiển thị thông báo chào mừng nếu có tên người dùng
            _buildNotificationItem(
              context,
              "Chào mừng $userName đến với chúng tôi!",
            ),
          _buildNotificationItem(
            context,
            "Đơn hàng của bạn đã được thanh toán thành công!",
          ),
        ],
      ),
    );
  }


  Widget _buildNotificationItem(BuildContext context, String message) {
    return ListTile(
      title: Text(
        message,
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_forward),
    );
  }
}
