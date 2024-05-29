import 'package:flutter/material.dart';

class HistoryShopping extends StatelessWidget {
  final List<TransactionItem> transactions;

  const HistoryShopping({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử giao dịch'),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'dateAscending',
                child: Text('Sắp xếp theo ngày (tăng dần)'),
              ),
              PopupMenuItem(
                value: 'dateDescending',
                child: Text('Sắp xếp theo ngày (giảm dần)'),
              ),
              PopupMenuItem(
                value: 'amountAscending',
                child: Text('Sắp xếp theo số tiền (tăng dần)'),
              ),
              PopupMenuItem(
                value: 'amountDescending',
                child: Text('Sắp xếp theo số tiền (giảm dần)'),
              ),
            ],
            onSelected: (String value) {
              // Xử lý sự kiện khi người dùng chọn một mục trong dropdown
              if (value == 'dateAscending') {
                transactions.sort((a, b) => a.date.compareTo(b.date));
              } else if (value == 'dateDescending') {
                transactions.sort((a, b) => b.date.compareTo(a.date));
              } else if (value == 'amountAscending') {
                transactions.sort((a, b) {
                  if (a.amount == null || b.amount == null) return 0;
                  double aAmount = double.tryParse(a.amount) ?? 0;
                  double bAmount = double.tryParse(b.amount) ?? 0;
                  return aAmount.compareTo(bAmount);
                });
              } else if (value == 'amountDescending') {
                transactions.sort((a, b) {
                  if (a.amount == null || b.amount == null) return 0;
                  double aAmount = double.tryParse(a.amount) ?? 0;
                  double bAmount = double.tryParse(b.amount) ?? 0;
                  return bAmount.compareTo(aAmount);
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return transactions[index];
        },
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String date;
  final String description;
  final String amount;
  final String status;

  const TransactionItem({
    required this.date,
    required this.description,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(Icons.shopping_bag),
        title: Text(description),
        subtitle: Text(date),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(amount),
            Text(
              status,
              style: TextStyle(
                color: status == 'Hoàn tất' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
