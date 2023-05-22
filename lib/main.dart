import 'package:flutter/material.dart';
import 'package:getx_login_fcm/screens/login.dart';
import 'package:get/get.dart';

void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: LoginPage(),
    );
  }
}
