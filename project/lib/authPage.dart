import 'package:flutter/material.dart';
import 'package:project/Loginpage.dart';
import 'package:project/signupPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({ Key? key }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
  isLogin ? loginPage(onclickSignup: toggle)
  : signupPage(onclickLogin: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}