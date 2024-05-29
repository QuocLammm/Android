import 'package:btl/bai_tap_lon/Update_history/history.dart';
import 'package:btl/bai_tap_lon/home/page_home_coffe.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentSuccessPage extends StatelessWidget {
  final int orderId;
  final double totalAmount;
  final DateTime orderDateTime;

  PaymentSuccessPage({required this.orderId, required this.totalAmount, required this.orderDateTime});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(orderDateTime);
    String amount = totalAmount.toStringAsFixed(0) + ' vnđ';
    TransactionItem newTransaction = TransactionItem(
      date: formattedDate,
      description: 'Đơn hàng $orderId',
      amount: amount,
      status: 'Hoàn tất',
    );

    // Thêm giao dịch mới vào store
    TransactionStore().addTransaction(newTransaction);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("asset/images/tich.png"), // Uncomment and provide the correct path to the success image
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
              child: Text('Tổng số tiền thanh toán: $amount'),
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
                          MaterialPageRoute(builder: (context) => PageHomeCf())
                      );
                    },
                    child: Text('Tiếp tục mua sắm'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              HistoryShopping(transactions: TransactionStore().getTransactions()))
                      );
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
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


class TransactionStore {
  static final TransactionStore _instance = TransactionStore._internal();
  List<TransactionItem> transactions = [];

  factory TransactionStore() {
    return _instance;
  }

  TransactionStore._internal();

  void addTransaction(TransactionItem transaction) {
    transactions.add(transaction);
  }

  List<TransactionItem> getTransactions() {
    return transactions;
  }

}

