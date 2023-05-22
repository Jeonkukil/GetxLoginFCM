import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getx_login_fcm/screens/login.dart';
import 'package:getx_login_fcm/screens/welcome.dart';

// 사용자의 로그인 환경에 따라서 각각 다른페이지로 이동 시켜줘야한다.
// 따라서 어떤 페이지건 접근이 가능해야 한다.
class AuthController extends GetxController {

  static AuthController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth authentication = FirebaseAuth.instance;

  // Getx 컨트롤러가 초기화된후 기본적인 렌더링이 끝나고 네트워크 정보들을 구현하기위해서 초기화시켜주기 위해 필요하다.
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    // 유저를 스트림에 바인딩했고 유저는 정보를 실시간으로 전달해준다.
    _user.bindStream(authentication.userChanges());
    // 로그아웃 이벤트는 언제든지 일어날 수 있다. 따라서 지속적으로 관찰해줘야 한다. Getx는 ever라는 메서드를 가지고있다. 이런 간편한 때문에 Getx가 좋다.
    //  아래의 코드는 지속적인 이밴트확인이 가능하게한다.
    ever(_user, _moveToPage);
  }
  
  _moveToPage(User? user){
    if(user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => WelcomePage());
    }
  }

  void register(String email, password) async {
    try{
      await authentication.createUserWithEmailAndPassword(
          email: email,
          password: password);
    }catch(e){
      Get.snackbar(
          "Error message",
          "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text("Registratopm is failed", style: TextStyle(
          color: Colors.white
        ),),
        messageText: Text(e.toString(), style: TextStyle(
          color: Colors.white,
        ),),
      );
    }
  }
}