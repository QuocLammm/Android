//lop mo ta du lieu
import 'package:cloud_firestore/cloud_firestore.dart';

class Fruit{
  String id;
  String ten;
  String? anh;
  int gia;
  String? moTa;
  Fruit({required this.id,required this.ten, required this.anh, required this.gia,this.moTa});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'anh': this.anh,
      'gia': this.gia,
      'moTa': this.moTa,
    };
  }

  factory Fruit.fromJson(Map<String, dynamic> map) {
    return Fruit(
      id: map['id'] as String,
      ten: map['ten'] as String,
      anh: map['anh'] as String,
      gia: map['gia'] as int,
      moTa: map['moTa'] as String,
    );
  }
}

//Lớp truy cập dữ liệu
class FruitSnapshot{
  Fruit fruit; // biến vị trí của document trên firebase_storage
  DocumentReference ref;

  FruitSnapshot({required this.fruit,required this.ref});

  factory FruitSnapshot.fromMap(DocumentSnapshot docSnap){
    return FruitSnapshot(
        fruit: Fruit.fromJson(docSnap.data() as Map<String, dynamic>), // ép kiểu
        ref: docSnap.reference
    );
  }

  static Future<DocumentReference> them(Fruit fruit) async {
    return FirebaseFirestore.instance.collection("Fruits").add(fruit.toJson());
  }

  //Cập nhật dữ liệu
  Future<void> capNhat(Fruit fruit) async{
    return ref.update(fruit.toJson());
  }

  //Xóa dữ liệu
  Future<void> xoa() async{
    return ref.delete();
  }

  //Truy vấn dữ liệu theo thời gian thực
  static Stream<List<FruitSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Fruits").snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => FruitSnapshot.fromMap(docSnap)
        ).toList()
    );
  }

  //Truy vấn dữ liệu một lần
  static Future<List<FruitSnapshot>> getAll2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Fruits").get();
    return qs.docs.map(
            (docSnap) => FruitSnapshot.fromMap(docSnap)
    ).toList();
  }
}


class GioHangItem{
  Fruit f;
  int soLuong;

  GioHangItem({required this.f,required this.soLuong});
}


////////////////////////////////Coffee///////////////////
class Drink{
  String id;
  String ten;
  String? anh;
  int gia;
  String? moTa;
  Drink({required this.id,required this.ten, required this.anh, required this.gia,this.moTa});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'anh': this.anh,
      'gia': this.gia,
      'moTa': this.moTa,
    };
  }

  factory Drink.fromJson(Map<String, dynamic> map) {
    return Drink(
      id: map['id'] as String,
      ten: map['ten'] as String,
      anh: map['anh'] as String,
      gia: map['gia'] as int,
      moTa: map['moTa'] as String,
    );
  }
}

//Lớp truy cập dữ liệu
class DrinkSnapshot{
  Drink drink; // biến vị trí của document trên firebase_storage
  DocumentReference ref;

  DrinkSnapshot({required this.drink,required this.ref});

  factory DrinkSnapshot.fromMap(DocumentSnapshot docSnap){
    return DrinkSnapshot(
        drink: Drink.fromJson(docSnap.data() as Map<String, dynamic>), // ép kiểu
        ref: docSnap.reference
    );
  }

  static Future<DocumentReference> themD(Fruit fruit) async {
    return FirebaseFirestore.instance.collection("Foods").add(fruit.toJson());
  }

  //Cập nhật dữ liệu
  Future<void> capNhatD(Fruit fruit) async{
    return ref.update(fruit.toJson());
  }

  //Xóa dữ liệu
  Future<void> xoaD() async{
    return ref.delete();
  }

  //Truy vấn dữ liệu theo thời gian thực
  static Stream<List<DrinkSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Foods")
        .snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => DrinkSnapshot.fromMap(docSnap)).toList()
    );
  }

  //
  static Stream<List<DrinkSnapshot>> getTop3(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Foods")
        .limit(3)
        .snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => DrinkSnapshot.fromMap(docSnap)).toList()
    );
  }
  //
  static Future<List<DrinkSnapshot>> getAllOnce() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Foods").get();
    return qs.docs.map((docSnap) => DrinkSnapshot.fromMap(docSnap)).toList();
  }

  //Truy vấn dữ liệu một lần
  static Future<List<DrinkSnapshot>> getAll2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Foods").get();
    return qs.docs.map(
            (docSnap) => DrinkSnapshot.fromMap(docSnap)
    ).toList();
  }
}


class GioHangItemm{
  Drink dr;
  int sl;

  GioHangItemm({required this.dr,required this.sl});
}

///////////////////////Tea////////////////////////
class DrinkTea{
  String id;
  String ten;
  String? anh;
  int gia;
  String? moTa;
  DrinkTea({required this.id,required this.ten, required this.anh, required this.gia,this.moTa});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'anh': this.anh,
      'gia': this.gia,
      'moTa': this.moTa,
    };
  }

  factory DrinkTea.fromJson(Map<String, dynamic> map) {
    return DrinkTea(
      id: map['id'] as String,
      ten: map['ten'] as String,
      anh: map['anh'] as String,
      gia: map['gia'] as int,
      moTa: map['moTa'] as String,
    );
  }
}

//Lớp truy cập dữ liệu
class DrinkTeaSnapshot{
  DrinkTea drinkTea; // biến vị trí của document trên firebase_storage
  DocumentReference ref;

  DrinkTeaSnapshot({required this.drinkTea,required this.ref});

  factory DrinkTeaSnapshot.fromMap(DocumentSnapshot docSnap){
    return DrinkTeaSnapshot(
        drinkTea: DrinkTea.fromJson(docSnap.data() as Map<String, dynamic>), // ép kiểu
        ref: docSnap.reference
    );
  }

  static Future<DocumentReference> themDT(DrinkTea drinkTea) async {
    return FirebaseFirestore.instance.collection("Tea").add(drinkTea.toJson());
  }

  //Cập nhật dữ liệu
  Future<void> capNhatDT(DrinkTea drinkTea) async{
    return ref.update(drinkTea.toJson());
  }

  //Xóa dữ liệu
  Future<void> xoaDT() async{
    return ref.delete();
  }

  //Truy vấn dữ liệu theo thời gian thực
  static Stream<List<DrinkTeaSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Tea")
        .snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => DrinkTeaSnapshot.fromMap(docSnap)
        ).toList()
    );
  }
  ///
  static Stream<List<DrinkTeaSnapshot>> getTop3(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Tea")
        .limit(3)
        .snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => DrinkTeaSnapshot.fromMap(docSnap)
        ).toList()
    );
  }
  //Truy vấn dữ liệu một lần
  static Future<List<DrinkTeaSnapshot>> getAll2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Tea").get();
    return qs.docs.map(
            (docSnap) => DrinkTeaSnapshot.fromMap(docSnap)
    ).toList();
  }
}


class GioHangItemT{
  DrinkTea drinkTea;
  int sluong;

  GioHangItemT({required this.drinkTea,required this.sluong});
}


//////////////////////////Cake//////////////////////
///////////////////////Tea////////////////////////
class Cake{
  String id;
  String ten;
  String? anh;
  int gia;
  String? moTa;
  Cake({required this.id,required this.ten, required this.anh, required this.gia,this.moTa});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'anh': this.anh,
      'gia': this.gia,
      'moTa': this.moTa,
    };
  }

  factory Cake.fromJson(Map<String, dynamic> map) {
    return Cake(
      id: map['id'] as String,
      ten: map['ten'] as String,
      anh: map['anh'] as String,
      gia: map['gia'] as int,
      moTa: map['moTa'] as String,
    );
  }
}

//Lớp truy cập dữ liệu
class CakeSnapshot{
  Cake cake; // biến vị trí của document trên firebase_storage
  DocumentReference ref;

  CakeSnapshot({required this.cake,required this.ref});

  factory CakeSnapshot.fromMap(DocumentSnapshot docSnap){
    return CakeSnapshot(
        cake: Cake.fromJson(docSnap.data() as Map<String, dynamic>), // ép kiểu
        ref: docSnap.reference
    );
  }

  static Future<DocumentReference> themDTCake(Cake cake) async {
    return FirebaseFirestore.instance.collection("Cakes").add(cake.toJson());
  }

  //Cập nhật dữ liệu
  Future<void> capNhatDTCake(Cake cake) async{
    return ref.update(cake.toJson());
  }

  //Xóa dữ liệu
  Future<void> xoaDTCake() async{
    return ref.delete();
  }

  //Truy vấn dữ liệu theo thời gian thực
  static Stream<List<CakeSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Cakes")
        .snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => CakeSnapshot.fromMap(docSnap)
        ).toList()
    );
  }
  static Stream<List<CakeSnapshot>> getTop3(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Cakes")
        .limit(3)
        .snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => CakeSnapshot.fromMap(docSnap)
        ).toList()
    );
  }

  //Truy vấn dữ liệu một lần
  static Future<List<CakeSnapshot>> getAll2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Cakes").get();
    return qs.docs.map(
            (docSnap) => CakeSnapshot.fromMap(docSnap)
    ).toList();
  }
}


class GioHangItemC{
  Cake cake;
  int sluongC;

  GioHangItemC({required this.cake,required this.sluongC});
}