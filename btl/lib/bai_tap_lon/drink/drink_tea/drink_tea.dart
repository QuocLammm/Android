import 'package:btl/bai_tap_lon/drink/drink_tea/chi_tiet_drink_tea.dart';
import 'package:btl/bai_tap_lon/firebase/cotrollers.dart';
import 'package:btl/bai_tap_lon/payment/thanhtoan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class DrinkTea extends StatelessWidget {
  DrinkTea({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SP_Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách các loại trà"),
        backgroundColor: Colors.greenAccent,
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
              children: controller.dsspT.map(
                      (drT) => Card(
                    elevation: 2,
                    shadowColor: Colors.blue,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              PageChiTietDrinkTea(drinkTea: drT,),)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(drT.anh!))
                          ),
                          Text("${drT.ten}"),
                          Text("${drT.gia} vnđ",style: TextStyle(color: Colors.red),),
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
