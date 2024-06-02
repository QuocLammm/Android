import 'dart:math';
import 'package:btl/bai_tap_lon/Update_history/history.dart';
import 'package:btl/bai_tap_lon/Update_history/update.dart';
import 'package:btl/bai_tap_lon/firebase/cotrollers.dart';
import 'package:btl/bai_tap_lon/payment/accept_payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SP_Controller controller = Get.find<SP_Controller>();

    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.only(right:10.0,left: 10.0,bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GetBuilder<SP_Controller>(
                builder: (controller) {
                  if (controller.gioHangg.isEmpty &&
                      controller.gioHangT.isEmpty &&
                      controller.gioHangC.isEmpty &&
                      controller.gioHangJ.isEmpty) {
                    return Center(
                      child: Text(
                        'Không có sản phẩm trong giỏ hàng!',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  } else {
                    return ListView(
                      children: [
                        ...controller.gioHangg.map((item) =>
                            buildCartItem(context, item, controller)),
                        ...controller.gioHangT.map((item) =>
                            buildCartItem(context, item, controller)),
                        ...controller.gioHangC.map((item) =>
                            buildCartItem(context, item, controller)),
                        ...controller.gioHangJ.map((item) =>
                            buildCartItem(context, item, controller)),
                      ],
                    );
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  if (controller.gioHangg.isEmpty &&
                      controller.gioHangT.isEmpty &&
                      controller.gioHangC.isEmpty &&
                      controller.gioHangJ.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text('Thanh toán lỗi vì không có sản phẩm'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final totalAmount = controller.calculateTotalAmount();
                    Get.dialog(
                      PaymentConfirmationPage(
                        controller: controller,
                        totalAmount: totalAmount,
                      ),
                    );
                  }
                },
                child: Text(
                  'Thanh toán',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(BuildContext context, dynamic item,
      SP_Controller controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 3), // Viền đậm hơn
        borderRadius: BorderRadius.circular(10), // Bo tròn các góc
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        leading: Image.network(
            item is GioHangItemm ? item.dr.anh : (item is GioHangItemT ? item
                .drinkTea.anh : (item is GioHangItemC ? item.cake.anh : item
                .juices.anh))),
        title: Text(
            item is GioHangItemm ? item.dr.ten : (item is GioHangItemT ? item
                .drinkTea.ten : (item is GioHangItemC ? item.cake.ten : item
                .juices.ten))),
        subtitle: Text('Số lượng: ${item is GioHangItemm
            ? item.sluongCF
            : (item is GioHangItemT ? item.sluongT : (item is GioHangItemC
            ? item.sluongC
            : item.sluongJ))}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color:Colors.blue),
              onPressed: () {
                Get.to(() =>
                    PageUpdateDrink(
                      product: item is GioHangItemm ? item.dr :
                      (item is GioHangItemT ? item.drinkTea :
                      (item is GioHangItemC ? item.cake : item.juices)),
                      initialQuantity: item is GioHangItemm ? item.sluongCF :
                      (item is GioHangItemT ? item.sluongT :
                      (item is GioHangItemC ? item.sluongC : item.sluongJ)),
                    ));
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red,),
              onPressed: () {
                dynamic productToDelete;
                if (item is GioHangItemm) {
                  productToDelete = item.dr;
                } else if (item is GioHangItemT) {
                  productToDelete = item.drinkTea;
                } else if (item is GioHangItemC) {
                  productToDelete = item.cake;
                } else if (item is GioHangItemJ) {
                  productToDelete = item.juices;
                }
                controller.xoaSanPham(productToDelete);
              },
            ),
          ],
        ),
      ),
    );
  }
}

  // Hàm hienthiDiaLog chỉ hiển thị thông tin văn bản của sản phẩm mà không cần hình ảnh
  // void hienthiDiaLog(BuildContext context, SP_Controller controller, double totalAmount) {
  //   TransactionStore transactionStore = TransactionStore();
  //   var random = Random();
  //   int orderId = random.nextInt(1000000);
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         content: Container(
  //           width: MediaQuery.of(context).size.width * 0.75, // Chiều rộng là 3/4 màn hình
  //           padding: EdgeInsets.all(16.0),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   'Xác nhận thanh toán',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 18.0,
  //                   ),
  //                 ),
  //                 SizedBox(height: 16.0),
  //                 Text(
  //                   'Mã số đơn hàng: $orderId',
  //                   style: TextStyle(fontSize: 16.0),
  //                 ),
  //                 SizedBox(height: 8.0),
  //                 Text(
  //                   'Ngày giờ đặt: ${DateTime.now()}',
  //                   style: TextStyle(fontSize: 16.0),
  //                 ),
  //                 SizedBox(height: 16.0),
  //                 Text(
  //                   'Thông tin sản phẩm:',
  //                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
  //                 ),
  //                 SizedBox(height: 8.0),
  //                 // Hiển thị danh sách sản phẩm mà không có hình ảnh
  //                 ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: NeverScrollableScrollPhysics(),
  //                   itemCount: controller.gioHangg.length +
  //                       controller.gioHangT.length +
  //                       controller.gioHangC.length +
  //                       controller.gioHangJ.length,
  //                   itemBuilder: (context, index) {
  //                     dynamic item;
  //                     if (index < controller.gioHangg.length) {
  //                       item = controller.gioHangg[index];
  //                     } else if (index < controller.gioHangg.length + controller.gioHangT.length) {
  //                       item = controller.gioHangT[index - controller.gioHangg.length];
  //                     } else if (index < controller.gioHangg.length + controller.gioHangT.length + controller.gioHangC.length) {
  //                       item = controller.gioHangC[index - controller.gioHangg.length - controller.gioHangT.length];
  //                     } else {
  //                       item = controller.gioHangJ[index - controller.gioHangg.length - controller.gioHangT.length - controller.gioHangC.length];
  //                     }
  //                     return ListTile(
  //                       title: Text('${item is GioHangItemm ? item.dr.ten : (item is GioHangItemT ? item.drinkTea.ten : (item is GioHangItemC ? item.cake.ten : item.juices.ten))} x${item is GioHangItemm ? item.sluongCF : (item is GioHangItemT ? item.sluongT : (item is GioHangItemC ? item.sluongC : item.sluongJ))}'),
  //                     );
  //                   },
  //                 ),
  //                 SizedBox(height: 16.0),
  //                 Text(
  //                   'Tổng số tiền cần thanh toán là ${totalAmount.toStringAsFixed(0)} vnđ.',
  //                   style: TextStyle(fontSize: 16.0),
  //                 ),
  //                 SizedBox(height: 16.0),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         TransactionItem newTransaction = TransactionItem(
  //                           date: DateTime.now().toString(),
  //                           description: 'Thanh toán thất bại',
  //                           amount: '${totalAmount.toStringAsFixed(0)} vnđ.',
  //                           status: 'Thất bại',
  //                         );
  //                         transactionStore.addTransaction(newTransaction);
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: Text('Hủy'),
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         controller.xoaTatCaSanPham();
  //                         Navigator.of(context).pop();
  //                         Navigator.of(context).pushAndRemoveUntil(
  //                           MaterialPageRoute(
  //                             builder: (context) => PaymentSuccessPage(
  //                               orderId: orderId,
  //                               totalAmount: totalAmount,
  //                               orderDateTime: DateTime.now(),
  //                             ),
  //                           ),
  //                               (Route<dynamic> route) => false,
  //                         );
  //                       },
  //                       child: Text('Xác nhận'),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }


class PaymentConfirmationPage extends StatelessWidget {
  final SP_Controller controller;
  final double totalAmount;

  const PaymentConfirmationPage({
    Key? key,
    required this.controller,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionStore transactionStore = TransactionStore();
    var random = Random();
    int orderId = random.nextInt(1000000);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.75, // Chiều rộng là 3/4 màn hình
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Xác nhận thanh toán',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Mã số đơn hàng: $orderId',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Ngày giờ đặt: ${DateTime.now()}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Thông tin sản phẩm:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              // Hiển thị danh sách sản phẩm mà không có hình ảnh
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.gioHangg.length +
                    controller.gioHangT.length +
                    controller.gioHangC.length +
                    controller.gioHangJ.length,
                itemBuilder: (context, index) {
                  dynamic item;
                  if (index < controller.gioHangg.length) {
                    item = controller.gioHangg[index];
                  } else if (index < controller.gioHangg.length + controller.gioHangT.length) {
                    item = controller.gioHangT[index - controller.gioHangg.length];
                  } else if (index < controller.gioHangg.length + controller.gioHangT.length + controller.gioHangC.length) {
                    item = controller.gioHangC[index - controller.gioHangg.length - controller.gioHangT.length];
                  } else {
                    item = controller.gioHangJ[index - controller.gioHangg.length - controller.gioHangT.length - controller.gioHangC.length];
                  }
                  return ListTile(
                    title: Text('${item is GioHangItemm ? item.dr.ten : (item is GioHangItemT ? item.drinkTea.ten : (item is GioHangItemC ? item.cake.ten : item.juices.ten))} x${item is GioHangItemm ? item.sluongCF : (item is GioHangItemT ? item.sluongT : (item is GioHangItemC ? item.sluongC : item.sluongJ))}'),
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Tổng số tiền cần thanh toán là ${totalAmount.toStringAsFixed(0)} vnđ.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      TransactionItem newTransaction = TransactionItem(
                        date: DateTime.now().toString(),
                        description: 'Thanh toán thất bại',
                        amount: '${totalAmount.toStringAsFixed(0)} vnđ.',
                        status: 'Thất bại',
                      );
                      transactionStore.addTransaction(newTransaction);
                      Navigator.of(context).pop();
                    },
                    child: Text('Hủy'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.xoaTatCaSanPham();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => PaymentSuccessPage(
                            orderId: orderId,
                            totalAmount: totalAmount,
                            orderDateTime: DateTime.now(),
                          ),
                        ),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Text('Xác nhận'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
