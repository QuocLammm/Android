import 'package:btl/bai_tap_lon/Update/update.dart';
import 'package:btl/bai_tap_lon/firebase/cotrollers.dart';
import 'package:btl/bai_tap_lon/home/page_home_coffe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SP_Controller controller = Get.find<SP_Controller>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
                        ...controller.gioHangg.map((item) => buildCartItem(context, item, controller)),
                        ...controller.gioHangT.map((item) => buildCartItem(context, item, controller)),
                        ...controller.gioHangC.map((item) => buildCartItem(context, item, controller)),
                        ...controller.gioHangJ.map((item) => buildCartItem(context, item, controller)),
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
                    hienthiDiaLog(context, controller, totalAmount);
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
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(BuildContext context, dynamic item, SP_Controller controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 3), // Viền đậm hơn
        borderRadius: BorderRadius.circular(10), // Bo tròn các góc
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        leading: Image.network(item is GioHangItemm ? item.dr.anh : (item is GioHangItemT ? item.drinkTea.anh : (item is GioHangItemC ? item.cake.anh : item.juices.anh))),
        title: Text(item is GioHangItemm ? item.dr.ten : (item is GioHangItemT ? item.drinkTea.ten : (item is GioHangItemC ? item.cake.ten : item.juices.ten))),
        subtitle: Text('Số lượng: ${item is GioHangItemm ? item.sluongCF : (item is GioHangItemT ? item.sluongT : (item is GioHangItemC ? item.sluongC : item.sluongJ))}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Get.to(() => PageUpdateDrink(
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
              icon: Icon(Icons.delete),
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

  void hienthiDiaLog(BuildContext context, SP_Controller controller, double totalAmount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận thanh toán'),
          content: Text('Tổng số tiền cần thanh toán là ${totalAmount.toStringAsFixed(0)} vnđ'),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Xác nhận'),
              onPressed: () {
                controller.xoaTatCaSanPham();
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => PageHomeCf()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

