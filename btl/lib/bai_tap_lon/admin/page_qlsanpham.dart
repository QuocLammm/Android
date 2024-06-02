import 'package:btl/bai_tap_lon/admin/page_chinhsuasp.dart';
import 'package:btl/bai_tap_lon/admin/page_themmoisp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase/model.dart';

class PageQLySanPham extends StatefulWidget {
  final List<dynamic> products;

  PageQLySanPham({required this.products, super.key});

  @override
  State<PageQLySanPham> createState() => _PageQLySanPhamState();
}

class _PageQLySanPhamState extends State<PageQLySanPham> {
  @override
  Widget build(BuildContext context) {
    final dynamic type = widget.products.first;
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách sản phẩm"),
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          dynamic sp = widget.products[index];
          String? anh;
          String? tensp;
          int? gia;
          if (sp is DrinkSnapshot) {
            anh = sp.drink.anh;
            tensp = sp.drink.ten;
            gia = sp.drink.gia;
          } else if (sp is DrinkTeaSnapshot) {
            anh = sp.drinkTea.anh;
            tensp = sp.drinkTea.ten;
            gia = sp.drinkTea.gia;
          } else if (sp is CakeSnapshot) {
            anh = sp.cake.anh;
            tensp = sp.cake.ten;
            gia = sp.cake.gia;
          } else if (sp is JuiceSnapshot) {
            anh = sp.juices.anh;
            tensp = sp.juices.ten;
            gia = sp.juices.gia;
          } else {
            anh = '';
            tensp = '';
            gia = 0;
          }
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 2,
            shadowColor: Colors.blue,
            child: GestureDetector(
              onTap: () {
                // Handle tap event
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        anh ?? '',
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
                            tensp ?? 'No name',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "${gia ?? '0'} VNĐ",
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PageChinhSuaSP(product: sp),),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 32.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (sp is DrinkSnapshot) {
                          await sp.xoaD(sp.ref);
                        } else if (sp is DrinkTeaSnapshot) {
                          await sp.xoaDT(sp.ref);
                        } else if (sp is CakeSnapshot) {
                          await sp.xoaDTCake(sp.ref);
                        } else if (sp is JuiceSnapshot) {
                          await sp.xoaDTJuice(sp.ref);
                        }
                        // Cập nhật lại giao diện sau khi xóa dữ liệu
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 32.0,
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PageThemMoiSP(producttype: type),),

          );},
        child: Icon(Icons.add),
      ),
    );
  }
}
