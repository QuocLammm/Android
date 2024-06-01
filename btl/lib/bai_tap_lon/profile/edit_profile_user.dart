import 'dart:io';

import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:btl/bai_tap_lon/firebase/storage_image_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../firebase/model.dart';
class PageEditProfile extends StatefulWidget {
  MyUserSnapshot userSnapshot;
  PageEditProfile({required this.userSnapshot,super.key});

  @override
  State<PageEditProfile> createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {
  XFile? _xFile;
  String? imageurl;
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSDT = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa thông tin cá nhân"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipOval(
                    child: Container(
                      width: 128,
                      height: 128,
                      color: Colors.transparent,
                      child: (_xFile == null || _xFile!.path.isEmpty)
                          ? (widget.userSnapshot.user.anh == null
                          ? Image.asset(
                        "asset/images/default_avatar.png",
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        widget.userSnapshot.user.anh!,
                        fit: BoxFit.cover,
                      ))
                          : Image.file(
                        File(_xFile!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -15,
                    right: -15,
                    child: IconButton(
                      onPressed: () async {
                        _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (_xFile != null)
                          setState(() {});
                      },
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: txtTen,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,color: Colors.purple),
                        borderRadius:BorderRadius.circular(50)
                      ),
                      labelText: "Họ và tên",
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.person_outline_rounded),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: txtEmail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),

                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,color: Colors.purple),
                          borderRadius:BorderRadius.circular(50)
                      ),
                      labelText: "Email",
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.person_outline_rounded),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: txtSDT,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),

                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,color: Colors.purple),
                          borderRadius:BorderRadius.circular(50)
                      ),
                      labelText: "Số điện thoại",
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.person_outline_rounded),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15)
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          MyUser user = MyUser(
                              hoTen: txtTen.text,
                              email: txtEmail.text,
                              sdt: txtSDT.text,
                              anh: imageurl,
                          );
                          if(_xFile!=null){
                            showMySnackBar(context, "Đang cập nhật thông tin....", 10);
                            imageurl = await uploadImage(
                                imagePath: _xFile!.path,
                                folders: ["users"],
                                fileName: "${txtSDT.text}.jpg");
                            if(imageurl !=null){
                              user.anh = imageurl;
                              _capNhatUser(user);
                            }else{
                              showMySnackBar(context, "Đang cập nhật thông tin....", 10);
                              user.anh = widget.userSnapshot.user.anh;
                              _capNhatUser(user);
                            }
                          }else{
                            user.anh = widget.userSnapshot.user.anh;
                            _capNhatUser(user);
                          }
                          FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(txtEmail.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                        ),
                        child: Text("Cập nhật",style: TextStyle(color: Colors.black)))
                  ],
                ),
              )
            ],

          ),
        ),
      ),
    );
  }
  _capNhatUser(MyUser user){
    widget.userSnapshot.capNhat(user).then(
            (value) => showMySnackBar(
            context,
            "Cập nhật thành công sản phẩm: ${txtTen.text}",
            3)
    ).catchError((error){
      showMySnackBar(
          context,
          "Cập nhật không thành công sản phẩm: ${txtTen.text}",
          3
      );
    });
  }
  @override
  void initState() {
    txtTen.text = widget.userSnapshot.user.hoTen;
    txtEmail.text = widget.userSnapshot.user.email;
    txtSDT.text = widget.userSnapshot.user.sdt;

  }
}
