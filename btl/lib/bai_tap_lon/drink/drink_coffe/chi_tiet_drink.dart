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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: (w/0.9),
                child: Image.network(widget.drink.anh ?? "No image"),
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 2.0),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.drink.ten,
                      style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold,),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(widget.drink.moTa ?? "",style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 12
              ),),
            ),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 70,

                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    /*border: Border.all(color: Colors.black),*/
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey.shade900,
                          child: Icon(Icons.remove,color: Colors.white),
                        ),
                      ),
                      Text(
                        '$_quantity',
                        style: TextStyle(fontSize: 20),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey.shade900,
                          child: Icon(Icons.add,color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(
                    "${price} vnđ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
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
                  itemBuilder: (context, _) => SizedBox(
                    width: 30, // Adjust the width and height as needed
                    height: 30,
                    child: Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
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

            Spacer(),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade900
                              ),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(double.infinity,70)
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0)
                                  )
                              )
                          ),
                          onPressed: () {
                            final controller = Get.find<SP_Controller>();
                            controller.themvaoGHDr(widget.drink, _quantity);
                          },
                          child: Text("Thêm vào giỏ hàng",style: TextStyle(
                            color: Colors.white.withOpacity(0.9),

                          ),)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "TỔNG TIỀN: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("${price * _quantity} vnđ",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.red
                          ),),
                        ],
                      ),
                    ],
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