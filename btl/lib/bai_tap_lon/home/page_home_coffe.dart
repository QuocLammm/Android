
import 'dart:async';
import 'package:btl/bai_tap_lon/drink/drink.dart';
import 'package:btl/bai_tap_lon/drink/drink_coffe/chi_tiet_drink.dart';
import 'package:btl/bai_tap_lon/drink/drink_coffe/drink_coffe.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;



class PageHomeCf extends StatefulWidget {
  const PageHomeCf({super.key});

  @override
  _PageHomeCfState createState() => _PageHomeCfState();
}

class _PageHomeCfState extends State<PageHomeCf> {
  List<Drink> bestsellerItems = [];

  @override
  void initState() {
    super.initState();
    fetchBestSellers();
  }

  void fetchBestSellers() async {
    List<DrinkSnapshot> allDrinks = await DrinkSnapshot.getAllOnce();
    setState(() {
      bestsellerItems = allDrinks.map((snap) => snap.drink).take(8).toList(); // Fetch 3 best-selling drinks
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"), // tên người dùng
        leading: Icon(Icons.sailing),// Hình ảnh avt
        actions: [
          Row(
            children: [
              Icon(Icons.sailing),// lấy vị trí
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: badges.Badge(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => MyProfile()),
                    // );
                  },
                  child: Icon(Icons.shopping_cart),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Text("Best Seller"),
          bestsellerItems.isNotEmpty
              ? BestsellerViewPager(items: bestsellerItems)
              : CircularProgressIndicator(),
          Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 300,
              children: [
                Card(
                  color: Colors.lightBlue,
                  elevation: 1,
                  child: GestureDetector(
                    child: Column(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset("asset/images/td_hd.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text("Khuyến mãi ", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.redAccent,
                  elevation: 2,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DSDrink()),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset("asset/images/monan_hd.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text("Menu", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.yellowAccent,
                  elevation: 1,
                  child: GestureDetector(
                    child: Column(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset("asset/images/dh_hd.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text("Đơn hàng ", style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.green,
                  elevation: 1,
                  child: GestureDetector(
                    child: Column(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset("asset/images/ch_hd.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text("Cửa hàng ", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////


/////////////////
class BestsellerViewPager extends StatefulWidget {
  final List<Drink> items;

  BestsellerViewPager({required this.items});

  @override
  _BestsellerViewPagerState createState() => _BestsellerViewPagerState();
}

class _BestsellerViewPagerState extends State<BestsellerViewPager> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.items.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PageChiTietDrink(dr: widget.items[index]),
              ));
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      widget.items[index].anh ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.items[index].ten,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

