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
          if (controller.dsspC.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: controller.dsspC.length,
            itemBuilder: (context, index) {
              var sp = controller.dsspC[index];
              print("Rendering item: ${sp.ten}"); // Debug print
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 2,
                shadowColor: Colors.blue,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PageChiTietCake(cake: sp),)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            sp.anh ?? '',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error);
                            },
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sp.ten ?? 'No name',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "${sp.gia ?? 'No price'} vnđ",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add your logic to add item to cart here
                            print("Add to cart: ${sp.ten}");
                          },
                          icon: Icon(Icons.add_circle_outline, color: Colors.orange, size: 32.0),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
