import 'dart:io';

import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:btl/bai_tap_lon/firebase/storage_image_helper.dart';
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
              ClipOval(
                child: Container(
                  width: 128,
                  height: 128,
                  color: Colors.transparent,
                  child: _xFile == null ? Image.network(widget.userSnapshot.user.anh!) : Image.file(File(_xFile!.path)),
                ),
              ),
              Positioned(
                  child: IconButton(
                    onPressed: () async{
                      _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if(_xFile!= null)
                        setState(() {

                        });
                    },
                    icon: Icon(Icons.add_a_photo),
                  )
              ),
              TextField(
                controller: txtTen,
                decoration: InputDecoration(
                    labelText: "Họ và tên"
                ),
              ),
              TextField(
                controller: txtEmail,
                decoration: InputDecoration(
                    labelText: "Email"
                ),
              ),
              TextField(
                controller: txtSDT,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Số điện thoại"
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                          showMySnackBar(context, "Đang cập nhật sản phẩm....", 10);
                          imageurl = await uploadImage(
                              imagePath: _xFile!.path,
                              folders: ["fruit_app"],
                              fileName: "${txtSDT.text}.jpg");
                          if(imageurl !=null){
                            user.anh = imageurl;
                            _capNhatUser(user);
                          }else{
                            showMySnackBar(context, "Đang cập nhật sản phẩm....", 10);
                            user.anh = widget.userSnapshot.user.anh;
                            _capNhatUser(user);
                          }
                        }
                      },
                      child: Text("Cập nhật"))
                ],
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
