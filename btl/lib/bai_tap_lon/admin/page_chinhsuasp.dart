import 'dart:io';

import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../firebase/storage_image_helper.dart';

class PageChinhSuaSP extends StatefulWidget {
  final dynamic product;
  PageChinhSuaSP({required this.product, super.key});

  @override
  State<PageChinhSuaSP> createState() => _PageChinhSuaSPState();
}

class _PageChinhSuaSPState extends State<PageChinhSuaSP> {
  XFile? _xFile;
  String? imageurl;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();
  String folderName = "";
  void initState() {
    super.initState();
    initializeFields();
  }
  void initializeFields() {
    if (widget.product is DrinkSnapshot) {
      txtId.text = widget.product.drink.id.toString() ?? '';
      txtTen.text = widget.product.drink.ten ?? '';
      txtGia.text = widget.product.drink.gia?.toString() ?? '';
      txtMoTa.text = widget.product.drink.moTa ?? '';
      imageurl = widget.product.drink.anh ?? '';
    } else if (widget.product is DrinkTeaSnapshot) {
      txtId.text = widget.product.drinkTea.id ?? '';
      txtTen.text = widget.product.drinkTea.ten ?? '';
      txtGia.text = widget.product.drinkTea.gia?.toString() ?? '';
      txtMoTa.text = widget.product.drinkTea.moTa ?? '';
      imageurl = widget.product.drinkTea.anh ?? '';
    } else if (widget.product is CakeSnapshot) {
      txtId.text = widget.product.cake.id ?? '';
      txtTen.text = widget.product.cake.ten ?? '';
      txtGia.text = widget.product.cake.gia?.toString() ?? '';
      txtMoTa.text = widget.product.cake.moTa ?? '';
      imageurl = widget.product.cake.anh ?? '';
    } else if (widget.product is JuiceSnapshot) {
      txtId.text = widget.product.juices.id ?? '';
      txtTen.text = widget.product.juices.ten ?? '';
      txtGia.text = widget.product.juices.gia?.toString() ?? '';
      txtMoTa.text = widget.product.juices.moTa ?? '';
      imageurl = widget.product.juices.anh ?? '';
    }
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Cập nhật sản phẩm"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: w * 0.8,
                  height: w * 0.8 * 2 / 3,
                  child: _xFile == null ? Image.network(imageurl!) : Image.file(File(_xFile!.path)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (_xFile != null) {
                        setState(() {});
                      }
                    },
                    child: Text("Chọn ảnh"),
                  )
                ],
              ),
              TextField(
                controller: txtId,
                decoration: InputDecoration(labelText: "Id"),
              ),
              TextField(
                controller: txtTen,
                decoration: InputDecoration(labelText: "Tên"),
              ),
              TextField(
                controller: txtGia,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Giá"),
              ),
              TextField(
                controller: txtMoTa,
                decoration: InputDecoration(labelText: "Mô tả"),
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (widget.product is DrinkTeaSnapshot) {
                          folderName = "tea_app";
                        } else if (widget.product is CakeSnapshot) {
                          folderName = "cake_app";
                        } else if (widget.product is JuiceSnapshot) {
                          folderName = "juices_app";
                        } else {
                          folderName = "drink_coffee_app";
                        }
                        if (_xFile != null) {
                          showMySnackBar(context, "Đang sửa sản phẩm....", 10);
                          imageurl = await uploadImage(
                            imagePath: _xFile!.path,
                            folders: ["${folderName}"],
                            fileName: "${txtId.text}.jpg",
                          );
                          if (imageurl != null) {
                            if (widget.product is DrinkTeaSnapshot) {
                              DrinkTea sp = DrinkTea(
                                id: txtId.text,
                                ten: txtTen.text,
                                moTa: txtMoTa.text,
                                anh: imageurl,
                                gia: int.parse(txtGia.text),
                              );
                              _capNhatSP(sp);
                            } else if (widget.product is CakeSnapshot) {
                              Cake sp = Cake(
                                id: txtId.text,
                                ten: txtTen.text,
                                moTa: txtMoTa.text,
                                anh: imageurl,
                                gia: int.parse(txtGia.text),
                              );
                              _capNhatSP(sp);
                            } else if (widget.product is JuiceSnapshot) {
                              Juices sp = Juices(
                                id: txtId.text,
                                ten: txtTen.text,
                                moTa: txtMoTa.text,
                                anh: imageurl,
                                gia: int.parse(txtGia.text),
                              );
                              _capNhatSP(sp);
                            } else {
                              Drink sp = Drink(
                                id: txtId.text,
                                ten: txtTen.text,
                                moTa: txtMoTa.text,
                                anh: imageurl,
                                gia: int.parse(txtGia.text),
                              );
                              _capNhatSP(sp);
                            }
                          }
                        }
                      },
                      child: Text("Cập nhật sản phẩm")
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void _capNhatSP(dynamic sp) async {
    if (sp is Drink) {
      widget.product.capNhatD(sp).then((value) {
        showMySnackBar(
          context,
          "Cập nhật thành công sản phẩm: ${sp.ten}",
          3,
        );
      }).catchError((error) {
        showMySnackBar(
          context,
          "Cập nhật không thành công sản phẩm: ${sp.ten}",
          3,
        );
      });
    } else if (sp is DrinkTea) {
      widget.product.capNhatDT(sp).then((value) {
        showMySnackBar(
          context,
          "Cập nhật thành công sản phẩm: ${sp.ten}",
          3,
        );
      }).catchError((error) {
        showMySnackBar(
          context,
          "Cập nhật không thành công sản phẩm: ${sp.ten}",
          3,
        );
      });
    } else if (sp is Cake) {
      widget.product.capNhatDTCake(sp).then((value) {
        showMySnackBar(
          context,
          "Cập nhật thành công sản phẩm: ${sp.ten}",
          3,
        );
      }).catchError((error) {
        showMySnackBar(
          context,
          "Cập nhật không thành công sản phẩm: ${sp.ten}",
          3,
        );
      });
    } else if (sp is Juices) {
      widget.product.capNhatDTJuice(sp).then((value) {
        showMySnackBar(
          context,
          "Cập nhật thành công sản phẩm: ${sp.ten}",
          3,
        );
      }).catchError((error) {
        showMySnackBar(
          context,
          "Cập nhật không thành công sản phẩm: ${sp.ten}",
          3,
        );
      });
    }
  }
}

