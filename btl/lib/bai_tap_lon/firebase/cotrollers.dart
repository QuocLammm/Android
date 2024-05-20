
import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:get/get.dart';



class SP_Controller extends GetxController{
  final _dssp = <Fruit>[].obs;
  final _dsspp = <Drink>[].obs;// cofffee
  final _dsspT = <DrinkTea>[].obs;// tea
  final _dsspC = <Cake>[].obs;// cake
  final _gioHang = <GioHangItem>[].obs;
  final _gioHangg = <GioHangItemm>[].obs;// coffe
  final _gioHangT = <GioHangItemT>[].obs;// tea
  final _gioHangC = <GioHangItemC>[].obs;// cake
  List<Fruit> get dssp => _dssp.value;
  List<Drink> get dsspp => _dsspp.value; // coffee
  List<DrinkTea> get dsspT => _dsspT.value; // tea
  List<Cake> get dsspC => _dsspC.value; // cake

  List<GioHangItem> get gioHang => _gioHang.value;
  List<GioHangItemm> get gioHangg => _gioHangg.value;// coffee
  List<GioHangItemT> get gioHangT => _gioHangT.value;// tea
  List<GioHangItemC> get gioHangC => _gioHangC.value;// cake
  int get slmh => gioHang.length;

  @override
  void onReady() { // Hãy viết trong onReady
    super.onReady();
    docDL();
    docDLL();// Đọc dữ liệu trên cloud
    docDLLTea();// Đọc dữ liệu trên cloud
    docDLCake();// Đọc dữ liệu trên cloud
  }

  void themvaoGH(Fruit f){
    gioHang.add(GioHangItem(f: f, soLuong: 1));
    _gioHang.refresh();
  }

  Future<void> docDL() async{
    var list = await FruitSnapshot.getAll2();
    _dssp.value = list.map((fruitSnap) => fruitSnap.fruit).toList();
    _dssp.refresh(); // = update([dssp])
  }
////////////////////////////Coffee//////////////////

  void themvaoGHDr(Drink dr){
    gioHangg.add(GioHangItemm(dr: dr, sl: 2));
    _gioHangg.refresh();
  }

  Future<void> docDLL() async{
    var list = await DrinkSnapshot.getAll2();
    _dsspp.value = list.map((drinkSnap) => drinkSnap.drink).toList();
    _dsspp.refresh(); // = update([dssp])
  }

  ////////////////////////////Tea//////////////////
  void themvaoGHDrTea(DrinkTea drinkTea){
    gioHangT.add(GioHangItemT(drinkTea: drinkTea, sluong: 1));
    _gioHangT.refresh();
  }

  Future<void> docDLLTea() async{
    var list = await DrinkTeaSnapshot.getAll2();
    _dsspT.value = list.map((drinkTSnap) => drinkTSnap.drinkTea).toList();
    _dsspT.refresh(); // = update([dssp])
  }
  ///////////////
////////////////////////////Tea//////////////////
  void themvaoCake(Cake cake){
    gioHangC.add(GioHangItemC(cake: cake, sluongC: 1));
    _gioHangC.refresh();
  }

  Future<void> docDLCake() async{
    var list = await CakeSnapshot.getAll2();
    _dsspC.value = list.map((cakeSnap) => cakeSnap.cake).toList();
    _dsspC.refresh(); // = update([dssp])
  }
}