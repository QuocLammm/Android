import 'package:flutter/material.dart';

class HistoryShopping extends StatelessWidget {
  final List<TransactionItem> transactions;

  const HistoryShopping({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử giao dịch'),
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
