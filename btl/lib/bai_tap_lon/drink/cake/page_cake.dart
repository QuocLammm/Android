import 'dart:math';

import 'package:btl/bai_tap_lon/drink/cake/chi_tiet_cake.dart';
import 'package:btl/bai_tap_lon/drink/drink_coffe/chi_tiet_drink.dart';
import 'package:btl/bai_tap_lon/firebase/cotrollers.dart';
import 'package:btl/bai_tap_lon/payment/thanhtoan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class CakeCoffe extends StatelessWidget {

  CakeCoffe({super.key}); // Mặc định kích thước là 'vừa'

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SP_Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách bánh ngọt",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: badges.Badge(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartPage(),
                  ),
                );
              },
              child: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
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
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 2,
                shadowColor: Colors.blue,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PageChiTietCake(cake: sp,),
                    ),
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
                            _showSizeSelectionSheet(context, sp);
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.orange,
                            size: 32.0,
                          ),
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

  void _showSizeSelectionSheet(BuildContext context, var sp) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizeSelectionSheet(sp: sp);
      },
    );
  }
}

class SizeSelectionSheet extends StatefulWidget {
  final sp;

  SizeSelectionSheet({required this.sp});

  @override
  _SizeSelectionSheetState createState() => _SizeSelectionSheetState();
}

class _SizeSelectionSheetState extends State<SizeSelectionSheet> {
  int _selectedSizeIndex = 0;
  int _quantity = 1;
  late final List<int> _prices;

  final List<String> _sizes = ["Vừa", "To"]; // Chỉ giữ lại "Vừa" và "To"

  @override
  void initState() {
    super.initState();
    _generatePrices();
  }

  void _generatePrices() {
    final random = Random();
    final basePrice = widget.sp.gia;
    _prices = [
      basePrice + (random.nextInt(2) * 5000), // Giữ nguyên giá cho kích thước "Vừa"
      basePrice + 10000 + (random.nextInt(2) * 5000), // Giữ nguyên giá cho kích thước "To"
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 2 / 3,
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "${widget.sp.ten}",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          ...List.generate(_sizes.length, (index) {
            return ListTile(
              title: Text(_sizes[index]),
              trailing: Text("${_prices[index]} vnđ", style: TextStyle(fontSize: 14)),
              leading: Radio(
                value: index,
                groupValue: _selectedSizeIndex,
                onChanged: (value) {
                  setState(() {
                    _selectedSizeIndex = value as int;
                  });
                },
              ),
            );
          }),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    _quantity.toString(),
                    style: TextStyle(fontSize: 18.0),
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
              Text(
                "Tổng: ${_prices[_selectedSizeIndex] * _quantity} vnđ",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final controller = Get.find<SP_Controller>();
              controller.themvaoCake(widget.sp, _quantity);
              Navigator.of(context).pop();
            },
            child: Text("Thêm vào giỏ hàng"),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

