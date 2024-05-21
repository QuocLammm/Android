
import 'package:btl/bai_tap_lon/drink/drink_tea/chi_tiet_drink_tea.dart';
import 'package:btl/bai_tap_lon/drink/juice/chi_tiet_drink_juices.dart';
import 'package:btl/bai_tap_lon/firebase/cotrollers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class DrinkJuice extends StatelessWidget {
  DrinkJuice({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SP_Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách nước ép"),
        backgroundColor: Colors.greenAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: badges.Badge(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GioHangJuice(),)
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
              children: controller.dsspJ.map(
                      (drJ) => Card(
                    elevation: 2,
                    shadowColor: Colors.blue,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              PageChiTietDrinkJuice(juices: drJ,),)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(drJ.anh!))
                          ),
                          Text("${drJ.ten}"),
                          Text("${drJ.gia} vnđ",style: TextStyle(color: Colors.red),),
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

class GioHangJuice extends StatelessWidget {
  const GioHangJuice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My shoping cart tea"),
      ),
    );

  }
}