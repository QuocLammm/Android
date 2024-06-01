//1.
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadImage({required String imagePath, required List<String> folders,
  required String fileName}) async{
  String downloadUrl;
  //Tao doi tuong firebaseStorage
  FirebaseStorage _storage = FirebaseStorage.instance;
  //1. Thiet lap duong dan tren firebase storage
  Reference reference = _storage.ref();
  for(String f in folders)
    reference = reference.child(f);
  reference = reference.child(fileName);
  //2.Thiết lập metadata
  final metadata = SettableMetadata(
      contentType:'image/jpeg',
      customMetadata:{'pick-file-path':imagePath});
  //3. Upload anh len firebase storage va tra ve duong dan
  try{
    if(kIsWeb)
      await reference.putData(await XFile(imagePath).readAsBytes(),metadata);
    else
      await reference.putFile(File(imagePath),metadata);
    downloadUrl = await reference.getDownloadURL();
    return downloadUrl;
  } on FirebaseException catch (e) {
    print("Lỗi up ảnh lên firebase: ${e.toString()}");
    return Future.error("Lỗi upload file");
  }
}
Future<void> deleteImage({required List<String> folders, required String filename}){
  FirebaseStorage _storage = FirebaseStorage.instance;
  //1. Thiet lap duong dan tren firebase storage
  Reference reference = _storage.ref();
  for(String f in folders)
    reference = reference.child(f);
  reference = reference.child(filename);
  return reference.delete();
}