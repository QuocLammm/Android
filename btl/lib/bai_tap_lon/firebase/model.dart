//lop mo ta du lieu
import 'package:btl/bai_tap_lon/Update_history/history.dart';
import 'package:btl/bai_tap_lon/payment/accept_payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return FirebaseFirestore.instance.collection("DrinkCoffee").add(fruit.toJson());
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
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("DrinkCoffee")
        .snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => DrinkSnapshot.fromMap(docSnap)).toList()
    );
  }

  //
  static Future<List<DrinkSnapshot>> getAllOnce() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("DrinkCoffee").get();
    return qs.docs.map((docSnap) => DrinkSnapshot.fromMap(docSnap)).toList();
  }

  //Truy vấn dữ liệu một lần
  static Future<List<DrinkSnapshot>> getAll2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("DrinkCoffee").get();
    return qs.docs.map(
            (docSnap) => DrinkSnapshot.fromMap(docSnap)
    ).toList();
  }
}


class GioHangItemm{
  Drink dr;
  int sluongCF;

  GioHangItemm({required this.dr,required this.sluongCF});
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

  static Future<List<DrinkTeaSnapshot>> getAllOnce() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Tea").get();
    return qs.docs.map((docSnap) => DrinkTeaSnapshot.fromMap(docSnap)).toList();
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
  int sluongT;

  GioHangItemT({required this.drinkTea,required this.sluongT});
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
  //Truy vấn dữ liệu một lần
  static Future<List<CakeSnapshot>> getAll2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Cakes").get();
    return qs.docs.map(
            (docSnap) => CakeSnapshot.fromMap(docSnap)
    ).toList();
  }
//
  static Future<List<CakeSnapshot>> getAllOnce() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Cakes").get();
    return qs.docs.map((docSnap) => CakeSnapshot.fromMap(docSnap)).toList();
  }
}


class GioHangItemC {
  Cake cake;
  int sluongC;

  GioHangItemC({
    required this.cake,
    required this.sluongC,
  });
}

///////////////////Juices////////////
///////////////////////Tea////////////////////////
class Juices{
  String id;
  String ten;
  String? anh;
  int gia;
  String? moTa;
  Juices({required this.id,required this.ten, required this.anh, required this.gia,this.moTa});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'anh': this.anh,
      'gia': this.gia,
      'moTa': this.moTa,
    };
  }

  factory Juices.fromJson(Map<String, dynamic> map) {
    return Juices(
      id: map['id'] as String,
      ten: map['ten'] as String,
      anh: map['anh'] as String,
      gia: map['gia'] as int,
      moTa: map['moTa'] as String,
    );
  }
}

//Lớp truy cập dữ liệu
class JuiceSnapshot{
  Juices juices; // biến vị trí của document trên firebase_storage
  DocumentReference ref;

  JuiceSnapshot({required this.juices,required this.ref});

  factory JuiceSnapshot.fromMap(DocumentSnapshot docSnap){
    return JuiceSnapshot(
        juices: Juices.fromJson(docSnap.data() as Map<String, dynamic>), // ép kiểu
        ref: docSnap.reference
    );
  }

  static Future<DocumentReference> themDTJuice(Juices juices) async {
    return FirebaseFirestore.instance.collection("Juices").add(juices.toJson());
  }

  //Cập nhật dữ liệu
  Future<void> capNhatDTJuice(Juices juices) async{
    return ref.update(juices.toJson());
  }

  //Xóa dữ liệu
  Future<void> xoaDTJuice() async{
    return ref.delete();
  }

  //Truy vấn dữ liệu theo thời gian thực
  static Stream<List<JuiceSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Juices")
        .snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => JuiceSnapshot.fromMap(docSnap)
        ).toList()
    );
  }

  //Truy vấn dữ liệu một lần
  static Future<List<JuiceSnapshot>> getAll2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Juices").get();
    return qs.docs.map(
            (docSnap) => JuiceSnapshot.fromMap(docSnap)
    ).toList();
  }
  //
  static Future<List<JuiceSnapshot>> getAllOnce() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Juices").get();
    return qs.docs.map((docSnap) => JuiceSnapshot.fromMap(docSnap)).toList();
  }
}


class GioHangItemJ{
  Juices juices;
  int sluongJ;

  GioHangItemJ({required this.juices,required this.sluongJ});
}

///////////////////////Address

class Address {
  late String id;
  String name;
  String phone;
  String address;
  String note;
  bool? isDefault;

  Address({
    this.id = '',
    required this.name,
    required this.phone,
    required this.address,
    required this.note,
    this.isDefault,
  });

  // Convert Address object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'note': note,
      'isDefault': isDefault,
    };
  }

  // Create Address object from JSON
  factory Address.fromJson(Map<String, dynamic> json, String id) {
    return Address(
      id: id,
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      note: json['note'],
      isDefault: json['isDefault'],
    );
  }

  // Save address data to Firestore
  static Future<DocumentReference> addAddress(Address address) async {
    return FirebaseFirestore.instance.collection("Addresses").add(address.toJson());
  }

  // Update address data in Firestore
  static Future<void> updateAddress(Address address) async {
    return FirebaseFirestore.instance.collection("Addresses").doc(address.id).update(address.toJson());
  }

  // Delete address data from Firestore
  static Future<void> deleteAddress(String id) async {
    return FirebaseFirestore.instance.collection("Addresses").doc(id).delete();
  }

  // Get all addresses from Firestore
  static Stream<List<Address>> getAllAddresses() {
    return FirebaseFirestore.instance.collection("Addresses")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Address.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }
}
