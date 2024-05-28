import 'package:get/get.dart';
import 'model.dart'; // Ensure this imports your model definitions

class SP_Controller extends GetxController {
  final _dssp = <Fruit>[].obs;
  final _dsspp = <Drink>[].obs; // coffee
  final _dsspT = <DrinkTea>[].obs; // tea
  final _dsspC = <Cake>[].obs; // cake
  final _dsspJ = <Juices>[].obs; // juice
  final _gioHang = <GioHangItem>[].obs;
  final _gioHangg = <GioHangItemm>[].obs; // coffee
  final _gioHangT = <GioHangItemT>[].obs; // tea
  final _gioHangC = <GioHangItemC>[].obs; // cake
  final _gioHangJ = <GioHangItemJ>[].obs; // juice

  List<Fruit> get dssp => _dssp.value;
  List<Drink> get dsspp => _dsspp.value; // coffee
  List<DrinkTea> get dsspT => _dsspT.value; // tea
  List<Cake> get dsspC => _dsspC.value; // cake
  List<Juices> get dsspJ => _dsspJ.value; // juice

  List<GioHangItem> get gioHang => _gioHang.value;
  List<GioHangItemm> get gioHangg => _gioHangg.value; // coffee
  List<GioHangItemT> get gioHangT => _gioHangT.value; // tea
  List<GioHangItemC> get gioHangC => _gioHangC.value; // cake
  List<GioHangItemJ> get gioHangJ => _gioHangJ.value; // juice

  int get slmh => _gioHang.length;
  int get slmhC => _gioHangC.length;//Cake
  int get slmhT => _gioHangC.length;//Tea
  int get slmhCF => _gioHangC.length;//Coffe
  int get slmhJ => _gioHangC.length;//Juice



  @override
  void onReady() {
    super.onReady();
    docDL();
    docDLL();
    docDLLTea();
    docDLCake();
    docDLJuice();
  }

  void themvaoGH(Fruit f) {
    gioHang.add(GioHangItem(f: f, soLuong: 1));
    _gioHang.refresh();
  }

  Future<void> docDL() async {
    var list = await FruitSnapshot.getAll2();
    _dssp.value = list.map((fruitSnap) => fruitSnap.fruit).toList();
    _dssp.refresh();
  }

  //////////////// Coffee //////////////
  void themvaoGHDr(Drink dr, int quantity) {
    bool itemFound = false;

    // Iterate through the cart items to find if the cake already exists
    for (var item in _gioHangg) {
      if (item.dr.id == dr.id) {
        item.sluongCF += quantity;  // Increment the quantity
        itemFound = true;
        break;
      }
    }

    // If item not found, add a new item to the cart
    if (!itemFound) {
      _gioHangg.add(GioHangItemm(dr: dr, sluongCF: quantity));
    }
    _gioHangg.refresh(); // Refresh the observable list
  }

  Future<void> docDLL() async {
    var list = await DrinkSnapshot.getAll2();
    _dsspp.value = list.map((drinkSnap) => drinkSnap.drink).toList();
    _dsspp.refresh();
  }

  //////////////// Tea //////////////
  void themvaoGHDrTea(DrinkTea drinkTea, int quantity) {
    bool itemFound = false;

    // Iterate through the cart items to find if the cake already exists
    for (var item in _gioHangT) {
      if (item.drinkTea.id == drinkTea.id) {
        item.sluongT += quantity;  // Increment the quantity
        itemFound = true;
        break;
      }
    }
    // If item not found, add a new item to the cart
    if (!itemFound) {
      _gioHangT.add(GioHangItemT(drinkTea: drinkTea, sluongT: quantity));
    }
    _gioHangT.refresh(); // Refresh the observable list
  }

  Future<void> docDLLTea() async {
    var list = await DrinkTeaSnapshot.getAll2();
    _dsspT.value = list.map((drinkTSnap) => drinkTSnap.drinkTea).toList();
    _dsspT.refresh();
  }

  //////////////// Cake //////////////
  void themvaoCake(Cake cake, int quantity) {
    bool itemFound = false;

    // Iterate through the cart items to find if the cake already exists
    for (var item in _gioHangC) {
      if (item.cake.id == cake.id) {
        item.sluongC += quantity;  // Increment the quantity
        itemFound = true;
        break;
      }
    }

    // If item not found, add a new item to the cart
    if (!itemFound) {
      _gioHangC.add(GioHangItemC(cake: cake, sluongC: quantity));
    }
    _gioHangC.refresh(); // Refresh the observable list
  }



  Future<void> docDLCake() async {
    var list = await CakeSnapshot.getAll2();
    _dsspC.value = list.map((cakeSnap) => cakeSnap.cake).toList();
    _dsspC.refresh();
  }

  //////////////// Juice //////////////
  void themvaoJuice(Juices juices, int quantity) {
    bool itemFound = false;

    // Iterate through the cart items to find if the cake already exists
    for (var item in _gioHangJ) {
      if (item.juices.id == juices.id) {
        item.sluongJ += quantity;  // Increment the quantity
        itemFound = true;
        break;
      }
    }

    // If item not found, add a new item to the cart
    if (!itemFound) {
      _gioHangJ.add(GioHangItemJ(juices: juices, sluongJ: quantity));
    }
    _gioHangJ.refresh(); // Refresh the observable list
  }

  Future<void> docDLJuice() async {
    var list = await JuiceSnapshot.getAll2();
    _dsspJ.value = list.map((juiceSnap) => juiceSnap.juices).toList();
    _dsspJ.refresh();
  }

  void xoaSanPham(dynamic product) {
    // Kiểm tra loại sản phẩm và xóa khỏi giỏ hàng tương ứng
    if (product is Drink) {
      gioHangg.removeWhere((item) => item.dr == product);
      Get.find<SP_Controller>().update(); // Cập nhật giao diện
    } else if (product is DrinkTea) {
      gioHangT.removeWhere((item) => item.drinkTea == product);
      Get.find<SP_Controller>().update(); // Cập nhật giao diện
    } else if (product is Cake) {
      gioHangC.removeWhere((item) => item.cake == product);
      Get.find<SP_Controller>().update(); // Cập nhật giao diện
    } else if (product is Juices) {
      gioHangJ.removeWhere((item) => item.juices == product);
      Get.find<SP_Controller>().update(); // Cập nhật giao diện
    }
  }


  // Xóa all sản phẩm
  void xoaTatCaSanPham() {
    gioHangg.clear();
    gioHangT.clear();
    gioHangC.clear();
    gioHangJ.clear();
  }

  double calculateTotalAmount() {
    double total = 0.0;
    gioHangg.forEach((item) => total += item.dr.gia * item.sluongCF);
    gioHangT.forEach((item) => total += item.drinkTea.gia * item.sluongT);
    gioHangC.forEach((item) => total += item.cake.gia * item.sluongC);
    gioHangJ.forEach((item) => total += item.juices.gia * item.sluongJ);
    return total;
  }

  // Cập nhật
  void capNhatSoLuong(dynamic product, int quantity) {
    if (product is Drink) {
      for (var item in _gioHangg) {
        if (item.dr.id == product.id) {
          item.sluongCF = quantity;
          update();
          return;
        }
      }
    } else if (product is DrinkTea) {
      for (var item in _gioHangT) {
        if (item.drinkTea.id == product.id) {
          item.sluongT = quantity;
          update();
          return;
        }
      }
    } else if (product is Cake) {
      for (var item in _gioHangC) {
        if (item.cake.id == product.id) {
          item.sluongC = quantity;
          update();
          return;
        }
      }
    } else if (product is Juices) {
      for (var item in _gioHangJ) {
        if (item.juices.id == product.id) {
          item.sluongJ = quantity;
          update();
          return;
        }
      }
    }
  }
}
