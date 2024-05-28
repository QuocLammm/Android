import 'package:btl/bai_tap_lon/drink/cake/chi_tiet_cake.dart';
import 'package:btl/bai_tap_lon/firebase/cotrollers.dart';
import 'package:btl/bai_tap_lon/payment/thanhtoan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;


class CakeCoffe extends StatelessWidget {
  CakeCoffe({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SP_Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách bánh ngọt"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: badges.Badge(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ShoppingCartPage(),)
                );
              },
              child: Icon(Icons.shopping_cart, size: 30,),
            ),
          )
        ],
      ),
      body: GetX<SP_Controller>(
        builder: (controller) {
          return GridView.extent(
              maxCrossAxisExtent: 300,
              children: controller.dsspC.map(
                      (sp) => Card(
                    elevation: 2,
                    shadowColor: Colors.blue,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              PageChiTietCake(cake: sp),)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(sp.anh!))
                          ),
                          Text("${sp.ten}"),
                          Text("${sp.gia} vnđ",style: TextStyle(color: Colors.red),),
                        ],
                      ),
                    ),
                  )
              ).toList()
          );
        },
      ),
    );
  }
}
