import 'dart:io';

import 'package:btl/bai_tap_lon/drink/drink_coffe/drink_coffe.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../firebase/storage_image_helper.dart';

class PageThemMoiSP extends StatefulWidget {
  final dynamic producttype;
  PageThemMoiSP({required this.producttype, Key? key}) : super(key: key);

  @override
  State<PageThemMoiSP> createState() => _PageThemMoiSPState();
}

class _PageThemMoiSPState extends State<PageThemMoiSP> {
  XFile? _xFile;
  String? imageurl;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm mới sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                  child: _xFile == null
                      ? Icon(Icons.image)
                      : Image.file(File(_xFile!.path)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _xFile =
                      await ImagePicker().pickImage(source: ImageSource.gallery);
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
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String folderName;
                      if (widget.producttype is DrinkTeaSnapshot) {
                        folderName = "tea_app";
                      } else if (widget.producttype is CakeSnapshot) {
                        folderName = "cake_app";
                      } else if (widget.producttype is JuiceSnapshot) {
                        folderName = "juices_app";
                      } else {
                        folderName = "drink_coffee_app";
                      }
                      if (_xFile != null) {
                        showMySnackBar(context, "Đang thêm sản phẩm....", 10);
                        imageurl = await uploadImage(
                          imagePath: _xFile!.path,
                          folders: ["${folderName}"],
                          fileName: "${txtId.text}.jpg",
                        );
                        if (imageurl != null) {
                          if (widget.producttype is DrinkTeaSnapshot) {
                            DrinkTea sp = DrinkTea(
                              id: txtId.text,
                              ten: txtTen.text,
                              moTa: txtMoTa.text,
                              anh: imageurl,
                              gia: int.parse(txtGia.text),
                            );
                            DrinkTeaSnapshot.themDT(sp)
                                .then((value) => showMySnackBar(
                              context,
                              "Thêm thành công sản phẩm: ${txtTen.text}",
                              3,
                            ))
                                .catchError((onError) {
                              showMySnackBar(
                                context,
                                "Thêm không thành công sản phẩm: ${txtTen.text}",
                                3,
                              );
                            });
                          } else if (widget.producttype is CakeSnapshot) {
                            Cake sp = Cake(
                              id: txtId.text,
                              ten: txtTen.text,
                              moTa: txtMoTa.text,
                              anh: imageurl,
                              gia: int.parse(txtGia.text),
                            );
                            CakeSnapshot.themDTCake(sp)
                                .then((value) => showMySnackBar(
                              context,
                              "Thêm thành công sản phẩm: ${txtTen.text}",
                              3,
                            ))
                                .catchError((onError) {
                              showMySnackBar(
                                context,
                                "Thêm không thành công sản phẩm: ${txtTen.text}",
                                3,
                              );
                            });
                          } else if (widget.producttype is JuiceSnapshot) {
                            Juices sp = Juices(
                              id: txtId.text,
                              ten: txtTen.text,
                              moTa: txtMoTa.text,
                              anh: imageurl,
                              gia: int.parse(txtGia.text),
                            );
                            JuiceSnapshot.themDTJuice(sp)
                                .then((value) => showMySnackBar(
                              context,
                              "Thêm thành công sản phẩm: ${txtTen.text}",
                              3,
                            ))
                                .catchError((onError) {
                              showMySnackBar(
                                context,
                                "Thêm không thành công sản phẩm: ${txtTen.text}",
                                3,
                              );
                            });
                          } else {
                            Drink sp = Drink(
                              id: txtId.text,
                              ten: txtTen.text,
                              moTa: txtMoTa.text,
                              anh: imageurl,
                              gia: int.parse(txtGia.text),
                            );
                            DrinkSnapshot.themD(sp)
                                .then((value) => showMySnackBar(
                              context,
                              "Thêm thành công sản phẩm: ${txtTen.text}",
                              3,
                            ))
                                .catchError((onError) {
                              showMySnackBar(
                                context,
                                "Thêm không thành công sản phẩm: ${txtTen.text}",
                                3,
                              );
                            });
                          }
                        }
                      }
                    },
                    child: Text("Thêm"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
