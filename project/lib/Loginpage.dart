import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  final VoidCallback onclickSignup;
  const loginPage({Key? key, required this.onclickSignup}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final emailLogin = TextEditingController();
  final passwordLogin = TextEditingController();

  Future Login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailLogin.text.trim(), password: passwordLogin.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Warehouse")),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40),
            TextField(
              controller: emailLogin,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 5),
            TextField(
                controller: passwordLogin,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 20),
            ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                onPressed: Login,
                icon: Icon(Icons.lock_open),
                label: Text("Login")),
            SizedBox(height: 10),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.grey),
                    text: "Belum punya akun? ",
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onclickSignup,
                      text: "Sign Up",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary))
                ]))
          ],
        ),
      ),
    );
  }
}
