import 'dart:math';
import 'package:badges/badges.dart' as badges;
import 'package:btl/bai_tap_lon/firebase/cotrollers.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:btl/bai_tap_lon/payment/thanhtoan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';


class PageChiTietDrink extends StatefulWidget {
  final Drink drink;
  PageChiTietDrink({required this.drink, Key? key}) : super(key: key);

  @override
  _PageChiTietCakeState createState() => _PageChiTietCakeState();
}

class _PageChiTietCakeState extends State<PageChiTietDrink> {
  int _quantity = 1;
  double _rating = (Random().nextInt(21)) / 10 + 3;
  double _ratingCount = (Random().nextInt(100) + 1000).toDouble();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.6;
    double h = MediaQuery.of(context).size.height * 0.6;
    int price = widget.drink.gia;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: badges.Badge(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                );
              },
              // badgeContent: Text("${controller.slhmC}"), // Show the number of items in the cart
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: w,
                child: Image.network(widget.drink.anh ?? "No image"),
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
                      widget.drink.ten,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.drink.moTa ?? ""),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${price} vnđ",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                            controller.themvaoGHDr(widget.drink, _quantity); // Navigate to the cart page
                          },
                          icon: Icon(Icons.add_shopping_cart, color: Colors.purple),
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