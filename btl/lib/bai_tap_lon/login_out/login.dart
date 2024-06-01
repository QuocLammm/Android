import 'package:btl/bai_tap_lon/admin/page_home_admin.dart';
import 'package:btl/bai_tap_lon/home/page_home_coffe.dart';
import 'package:btl/bai_tap_lon/security/baomat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return null; // return null if login is successful
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'Tài khoản không tồn tại';
        case 'wrong-password':
          return 'Mật khẩu không đúng';
        default:
          return 'Đã xảy ra lỗi';
      }
    }
  }

  Future<bool> _checkDuplicatePhoneNumber(String phoneNumber) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where('sdt', isEqualTo: phoneNumber)
        .get();

    return query.docs.isNotEmpty;
  }
  Future<String?> _signupUser(SignupData data) async {
    try {
      final additionalSignupData = data.additionalSignupData;
      String hoTen = additionalSignupData?['hoTen'] ?? '';
      String sdt = additionalSignupData?['sdt'] ?? '';
      bool isDuplicate = await _checkDuplicatePhoneNumber(sdt);
      if (isDuplicate) {
        return 'Số điện thoại đã được sử dụng';
      }
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'email': data.name,
        'hoTen': hoTen,
        'sdt': sdt,
        'role': 'user',
        'anh': '',
      });
      return null; // return null if signup is successful
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email đã có người sử dụng';
        case 'weak-password':
          return 'Mật khẩu quá yếu';
        default:
          return 'Đã xảy ra lỗi';
      }
    }
  }

  Future<String?> _recoverPassword(String name) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: name);
      return null; // return null if recovery email is sent
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Tài khoản không tồn tại';
      } else {
        return 'Đã xảy ra lỗi';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        title: 'Hello!',
        //logo: const AssetImage('assets/images/ecorp-lightblue.png'), // Add a logo if you like
        onLogin: _authUser,
        onSignup: _signupUser,
        loginProviders: [
          LoginProvider(
            icon: FontAwesomeIcons.google,
            label: 'Google',
            callback: () async {
              debugPrint('start google sign in');
              await Future.delayed(loginTime);
              debugPrint('stop google sign in');
              return null;
            },
          ),
          LoginProvider(
            icon: FontAwesomeIcons.facebookF,
            label: 'Facebook',
            callback: () async {
              debugPrint('start facebook sign in');
              await Future.delayed(loginTime);
              debugPrint('stop facebook sign in');
              return null;
            },
          ),
        ],
        additionalSignupFields: [
          UserFormField(
            keyName: 'hoTen',
            displayName: 'Họ và tên',
            icon: Icon(Icons.person),
          ),
          UserFormField(
            keyName: 'sdt',
            displayName: 'Số điện thoại',
            icon: Icon(Icons.phone),
            userType: LoginUserType.phone
          ),
        ],
        onSubmitAnimationCompleted: () async {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

            if (userDoc.exists) {
              String role = userDoc.get('role');
              if (role == 'admin') {
                Navigator.of(context).pushReplacement(
                  //Đăng nhập dưới dạng Admin
                  MaterialPageRoute(builder: (context) => PageHomeAdmin()),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PageHomeCf()),
                );
              }
            }
          }
        },
        onRecoverPassword: _recoverPassword,
        messages: LoginMessages(
          userHint: 'Email',
          passwordHint: 'Mật khẩu',
          confirmPasswordHint: 'Nhập lại mật khẩu',
          loginButton: 'ĐĂNG NHẬP',
          signupButton: 'ĐĂNG KÝ',
          forgotPasswordButton: 'Quên mật khẩu?',
          recoverPasswordButton: 'LẤY LẠI MẬT KHẨU',
          goBackButton: 'QUAY LẠI',
          confirmPasswordError: 'Mật khẩu không đúng!',
          recoverPasswordDescription:
          'Vui lòng nhập tên mail vào ô trống để tiến hành lấy mật khẩu',
          recoverPasswordSuccess: 'Mật khẩu đã được khôi phục thành công',
          recoverPasswordIntro: 'Lấy lại mật khẩu ở đây',
          providersTitleFirst: 'Hoặc',
        ),
      ),
    );
  }
}
