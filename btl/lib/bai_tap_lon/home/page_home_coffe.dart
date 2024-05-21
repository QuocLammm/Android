import 'dart:async';
import 'package:btl/bai_tap_lon/drink/cake/chi_tiet_cake.dart';
import 'package:btl/bai_tap_lon/drink/drink.dart';
import 'package:btl/bai_tap_lon/drink/drink_coffe/chi_tiet_drink.dart';
import 'package:btl/bai_tap_lon/drink/drink_tea/chi_tiet_drink_tea.dart';
import 'package:btl/bai_tap_lon/drink/juice/chi_tiet_drink_juices.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:btl/bai_tap_lon/home/page_information.dart';
import 'package:btl/bai_tap_lon/home/page_notification.dart';
import 'package:btl/bai_tap_lon/home/page_search.dart';
import 'package:btl/bai_tap_lon/home/page_setting.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class PageHomeCf extends StatefulWidget {
  const PageHomeCf({super.key});

  @override
  _PageHomeCfState createState() => _PageHomeCfState();
}

class _PageHomeCfState extends State<PageHomeCf> {
  List<dynamic> bestsellerItems = [];
  late String lat, long;

  final List<IconData> iconList = [
    Icons.search,
    Icons.notifications,
    Icons.account_circle_outlined,
    Icons.settings,
  ];

  final List<String> pageTitles = [
    "Tìm kiếm",
    "Thông báo",
    "Thông tin cá nhân",
    "Cài đặt",
    "Trang chủ",
  ];
  int index = 4; // index của bottom navigation bar

  @override
  void initState() {
    super.initState();
    fetchBestSellers();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      setState(() {});
    });
  }

  Future<void> _openMap(String lat, String long) async {
    String googleURL =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunchUrlString(googleURL)) {
      await launchUrlString(googleURL);
    } else {
      throw 'Could not launch $googleURL';
    }
  }

  void fetchBestSellers() async {
    List<DrinkSnapshot> drinkSnapshots = await DrinkSnapshot.getAllOnce();
    List<JuiceSnapshot> juiceSnapshots = await JuiceSnapshot.getAllOnce();
    List<DrinkTeaSnapshot> teaSnapshots = await DrinkTeaSnapshot.getAllOnce();
    List<CakeSnapshot> cakeSnapshots = await CakeSnapshot.getAllOnce();

    setState(() {
      bestsellerItems = [
        ...drinkSnapshots.map((snap) => snap.drink).take(6),
        ...juiceSnapshots.map((snap) => snap.juices).take(6),
        ...teaSnapshots.map((snap) => snap.drinkTea).take(4),
        ...cakeSnapshots.map((snap) => snap.cake).take(4)
      ]; // Fetch 8 best-selling items
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(pageTitles[index]), // tên người dùng
        leading: Icon(Icons.sailing), // Hình ảnh avt
        actions: [
          Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        _getCurrentLocation().then((value) {
                          lat = '${value.latitude}';
                          long = '${value.longitude}';
                          setState(() {
                            print(lat);
                            print(long);
                          });
                          _liveLocation();
                          _openMap(lat, long);
                        });
                      },
                      child: Icon(Icons.location_on_outlined))
                ],
              ), // lấy vị trí
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: badges.Badge(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => MyProfile()),
                    // );// giỏ hàng
                  },
                  child: Icon(Icons.shopping_cart),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(context, index),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.home,
            color: Colors.black,
          ),
          backgroundColor: Colors.green,
          onPressed: () {
            setState(() {
              index = 4; // Set index to home page
            });
          },
          shape: CircleBorder()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (index, isActive) {
          return Icon(
            iconList[index],
            size: 24,
            color: isActive ? Colors.green : Colors.white,
          );
        },
        backgroundColor: Colors.black54,
        shadow: BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.black,
        ),
        activeIndex: index,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (selectedIndex) => setState(() {
          index = selectedIndex;
        }),
      ),
    );
  }

  Widget _buildBody(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _buildSearchPage();
      case 1:
        return _buildNotificationsPage();
      case 2:
        return _buildInforPage();
      case 3:
        return _buildSettingsPage();
      case 4:
        return _buildHomePage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildInforPage() {
    return PageProfile();
  }

  Widget _buildSettingsPage() {
    return PageSetting();
  }

  Widget _buildNotificationsPage() {
    return PageNotification();
  }

  Widget _buildSearchPage() {
    return PageSearch();
  }

  Widget _buildHomePage() {
    return buildPageHome(bestsellerItems: bestsellerItems);
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

class buildPageHome extends StatelessWidget {
  const buildPageHome({
    super.key,
    required this.bestsellerItems,
  });

  final List<dynamic> bestsellerItems;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        child: Text("Khuyến mãi ",
                            style: TextStyle(color: Colors.white)),
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
                        child:
                        Text("Menu", style: TextStyle(color: Colors.white)),
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
                        child: Text("Đơn hàng ",
                            style: TextStyle(color: Colors.black)),
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
                        child: Text("Cửa hàng ",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BestsellerViewPager extends StatefulWidget {
  final List<dynamic> items;

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
          // Determine the type of the item and build accordingly
          if (widget.items[index] is Drink) {
            return _buildDrinkItem(widget.items[index]);
          } else if (widget.items[index] is Juices) {
            return _buildJuiceItem(widget.items[index]);
          } else if (widget.items[index] is DrinkTea) {
            return _buildDrinkTeaItem(widget.items[index]);
          } else if (widget.items[index] is Cake) {
            return _buildCakeItem(widget.items[index]);
          } else {
            return Container(); // Return empty container if the item type is unknown
          }
        },
      ),
    );
  }

  Widget _buildDrinkItem(Drink drink) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PageChiTietDrink(dr: drink),
        ));
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                drink.anh ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                drink.ten,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJuiceItem(Juices juice) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PageChiTietDrinkJuice(juices: juice,),
        ));
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                juice.anh ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                juice.ten,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
    // Placeholder
  }

  Widget _buildDrinkTeaItem(DrinkTea drinkTea) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PageChiTietDrinkTea(drinkTea: drinkTea),
        ));
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                drinkTea.anh ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                drinkTea.ten,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
    // Placeholder
  }

  Widget _buildCakeItem(Cake cake) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PageChiTietCake(cake: cake,),
        ));
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                cake.anh ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cake.ten,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
     // Placeholder
  }
}

