import 'package:btl/bai_tap_lon/home/page_home_coffe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
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
          return 'User not exists';
        case 'wrong-password':
          return 'Password does not match';
        default:
          return 'An error occurred';
      }
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );
      return null; // return null if signup is successful
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email already in use';
        case 'weak-password':
          return 'Password is too weak';
        default:
          return 'An error occurred';
      }
    }
  }

  Future<String?> _recoverPassword(String name) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: name);
      return null; // return null if recovery email is sent
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not exists';
      } else {
        return 'An error occurred';
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'LTP',
      //logo: const AssetImage('assets/images/ecorp-lightblue.png') //them anh neu thich,
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
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const PageHomeCf(),
        ));
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
        providersTitleFirst: 'Đăng nhập bằng tài khoản khác'
      ),
    );
  }
}
