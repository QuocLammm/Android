import 'dart:math';
import 'package:badges/badges.dart' as badges;
import 'package:btl/bai_tap_lon/firebase/cotrollers.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PageChiTietDrinkJuice extends StatelessWidget {
  Juices juices;
  PageChiTietDrinkJuice({required this.juices, super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width*0.9;
    double rating = (Random().nextInt(21))/10+3;
    double rating_person = (Random().nextInt(100)+1000);
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
                      MaterialPageRoute(builder: (context)=> PageGioHangFruitJ()));
                },
                //badgeContent: Text("${}"),
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
                  child: Image.network(juices.anh ?? "No image"),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(juices.ten,style: TextStyle(color: Colors.blue,fontSize: 30),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${juices.gia} vnđ",style: TextStyle(color: Colors.red,fontSize: 20),),
                        SizedBox(width: 10,),
                        Text("${juices.gia*1.8} vnđ",style: TextStyle(fontSize:20,decoration: TextDecoration.lineThrough),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(juices.moTa!),
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating:rating,
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
                            print(rating);
                          },
                        ),
                        Text("${rating}",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.red),),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final controller = Get.find<SP_Controller>();
            controller.themvaoJuice(juices);
          },
          child: Icon(Icons.add_shopping_cart_outlined, color: Colors.purple,),
        )
    );
  }
}


class PageGioHangFruitJ extends StatelessWidget {
  const PageGioHangFruitJ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}