import 'package:btl/bai_tap_lon/drink/cake/chi_tiet_cake.dart';
import 'package:btl/bai_tap_lon/drink/drink_coffe/chi_tiet_drink.dart';
import 'package:btl/bai_tap_lon/drink/drink_tea/chi_tiet_drink_tea.dart';
import 'package:btl/bai_tap_lon/drink/juice/chi_tiet_drink_juices.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:flutter/material.dart';

class PageSearch extends StatefulWidget {
  const PageSearch({super.key});

  @override
  _PageSearchState createState() => _PageSearchState();
}

class _PageSearchState extends State<PageSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredProducts = [];

  void _searchProducts(String query) async {
    final fruits = await FruitSnapshot.getAll2();
    final drinks = await DrinkSnapshot.getAllOnce();
    final teas = await DrinkTeaSnapshot.getAll2();
    final cakes = await CakeSnapshot.getAll2();
    final juices = await JuiceSnapshot.getAll2();

    final filteredFruits = fruits.where((item) => item.fruit.ten.toLowerCase().contains(query.toLowerCase())).toList();
    final filteredDrinks = drinks.where((item) => item.drink.ten.toLowerCase().contains(query.toLowerCase())).toList();
    final filteredTeas = teas.where((item) => item.drinkTea.ten.toLowerCase().contains(query.toLowerCase())).toList();
    final filteredCakes = cakes.where((item) => item.cake.ten.toLowerCase().contains(query.toLowerCase())).toList();
    final filteredJuices = juices.where((item) => item.juices.ten.toLowerCase().contains(query.toLowerCase())).toList();

    setState(() {
      _filteredProducts = [...filteredFruits, ...filteredDrinks, ...filteredTeas, ...filteredCakes, ...filteredJuices];
    });
  }
  void _navigateToDetail(dynamic product) {
    if (product is JuiceSnapshot) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageChiTietDrinkJuice(juices: product.juices),
        ),
      );
    } else if (product is DrinkSnapshot) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageChiTietDrink(drink: product.drink),
        ),
      );
    } else if (product is DrinkTeaSnapshot) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageChiTietDrinkTea(drinkTea: product.drinkTea),
        ),
      );
    } else if (product is CakeSnapshot) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageChiTietCake(cake: product.cake),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm sản phẩm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                _searchProducts(query);
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  String name, imageUrl;
                  int price;

                  if (product is FruitSnapshot) {
                    name = product.fruit.ten;
                    imageUrl = product.fruit.anh ?? '';
                    price = product.fruit.gia;
                  } else if (product is DrinkSnapshot) {
                    name = product.drink.ten;
                    imageUrl = product.drink.anh ?? '';
                    price = product.drink.gia;
                  } else if (product is DrinkTeaSnapshot) {
                    name = product.drinkTea.ten;
                    imageUrl = product.drinkTea.anh ?? '';
                    price = product.drinkTea.gia;
                  } else if (product is CakeSnapshot) {
                    name = product.cake.ten;
                    imageUrl = product.cake.anh ?? '';
                    price = product.cake.gia;
                  } else if (product is JuiceSnapshot) {
                    name = product.juices.ten;
                    imageUrl = product.juices.anh ?? '';
                    price = product.juices.gia;
                  } else {
                    return Container();
                  }

                  return ListTile(
                    leading: imageUrl.isNotEmpty ? Image.network(imageUrl, width: 50, height: 50) : null,
                    title: Text(name),
                    trailing: Text('$price VND'),
                    onTap: () => _navigateToDetail(product),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}


