import 'package:btl/bai_tap_lon/Update_history/history.dart';
import 'package:btl/bai_tap_lon/home/page_home_coffe.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Thư viện để định dạng ngày giờ

class PaymentSuccessPage extends StatelessWidget {
  final int orderId;
  final double totalAmount;
  final DateTime orderDateTime; // Thêm thuộc tính cho ngày giờ

  PaymentSuccessPage({required this.orderId, required this.totalAmount, required this.orderDateTime});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(orderDateTime); // Định dạng ngày giờ

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image.asset("asset/images/tich.png"), // Đường dẫn hình ảnh thành công
            SizedBox(height: 20),
            Text(
              'Đặt hàng thành công',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('Mã số đơn hàng: $orderId'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('Thời gian đặt hàng: $formattedDate'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('Tổng số tiền thanh toán: ${totalAmount.toStringAsFixed(0)} vnđ'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('Bạn đã đặt thành công đơn hàng và đã thanh toán'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('Bạn có thể theo dõi đơn hàng ở lịch sử đơn hàng bấm ở phía dưới đây'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('Tour Les Temp rất vui được phục vụ quý khách!'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PageHomeCf(),)
                      );
                      // Xử lý khi nhấn nút "Tiếp tục mua sắm"
                    },
                    child: Text('Tiếp tục mua sắm'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red), // Viền màu đỏ
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút "Lịch sử đơn hàng"
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HistoryShopping(),)
                      );
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red), // Chữ màu đỏ
                    ),
                    child: Text('Lịch sử đơn hàng'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
