import 'package:btl/bai_tap_lon/firebase/cotrollers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';

class PageUpdateDrink extends StatefulWidget {
  final dynamic product;
  final int initialQuantity;

  PageUpdateDrink({required this.product, required this.initialQuantity, Key? key}) : super(key: key);

  @override
  _PageUpdateDrinkState createState() => _PageUpdateDrinkState();
}

class _PageUpdateDrinkState extends State<PageUpdateDrink> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.6;
    int price = widget.product.gia;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: w,
                child: Image.network(widget.product.anh ?? "No image"),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 2.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.product.ten,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.product.moTa ?? ""),
            ),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Giá tiền: ${price} vnđ",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 86.0),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        '$_quantity',
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Tổng Tiền: ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text("${price * _quantity} vnđ"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            final controller = Get.find<SP_Controller>();
                            controller.capNhatSoLuong(widget.product, _quantity);
                            Get.back();
                          },
                          icon: Text("Cập nhật"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
