import 'package:btl/bai_tap_lon/drink/cake/page_cake.dart';
import 'package:btl/bai_tap_lon/drink/drink_coffe/drink_coffe.dart';
import 'package:btl/bai_tap_lon/drink/drink_tea/drink_tea.dart';
import 'package:flutter/material.dart';


class DSDrink extends StatelessWidget {
  const DSDrink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Menu"),
      ),
      body: GridView.extent(
          maxCrossAxisExtent: 380,
        children: [
          Card(
            color: Colors.black,
            elevation: 1,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder:(context) => DrinkCoffe(),)
              ),
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
                    child: Text("Cà phê ",
                      style: TextStyle(color: Colors.white, fontSize: 20),),
                  )
                ],
              ),
            ),
          ),
          Card(
            color: Colors.greenAccent,
            elevation: 1,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder:(context) => DrinkTea(),)
              ),
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
                    child: Text("Trà giải nhiệt ",
                      style: TextStyle(color: Colors.white, fontSize: 20),),
                  )
                ],
              ),
            ),
          ),
          Card(
            color: Colors.pinkAccent,
            elevation: 1,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder:(context) => CakeCoffe(),)
              ),
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
                    child: Text("Bánh ngọt ",
                      style: TextStyle(color: Colors.white, fontSize: 20),),
                  )
                ],
              ),
            ),
          ),
          Card(
            color: Colors.tealAccent,
            elevation: 1,
            child: GestureDetector(
              // onTap: () => Navigator.of(context).push(
              //     MaterialPageRoute(builder:(context) => DrinkTea(),)
              // ),
              child: Column(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset("asset/images/soda.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text("Các loại thức uống khác",
                      style: TextStyle(color: Colors.black54, fontSize: 20),),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//////////
