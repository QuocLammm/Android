import 'package:btl/bai_tap_lon/drink/cake/page_cake.dart';
import 'package:btl/bai_tap_lon/drink/drink_coffe/drink_coffe.dart';
import 'package:btl/bai_tap_lon/drink/drink_tea/drink_tea.dart';
import 'package:btl/bai_tap_lon/drink/juice/drink_juices.dart';
import 'package:flutter/material.dart';

class DSDrink extends StatelessWidget {
  const DSDrink({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Danh mục"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DrinkCoffe()),
              ),
              child: Card(
                color: Colors.black,
                elevation: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset("asset/images/hinh-anh-ly-ca-phe.jpg"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Cà phê ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DrinkTea()),
              ),
              child: Card(
                color: Colors.greenAccent,
                elevation: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset("asset/images/tdao.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Trà giải nhiệt ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CakeCoffe()),
              ),
              child: Card(
                color: Colors.pinkAccent,
                elevation: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset("asset/images/banh_ngot.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Bánh ngọt ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DrinkJuice()),
              ),
              child: Card(
                color: Colors.tealAccent,
                elevation: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset("asset/images/ep.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Các loại nước ép",
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
