import 'package:email_validator/email_validator.dart';
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
  final formKey = GlobalKey<FormState>();
  final emailLogin = TextEditingController();
  final passwordLogin = TextEditingController();

  Future Login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailLogin.text.trim(), password: passwordLogin.text.trim());
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email/Password Salah")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Warehouse"), centerTitle: true),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 40),
              TextFormField(
                controller: emailLogin,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Enter a valid email"
                        : null,
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: passwordLogin,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? "Enter minimal 6 characters"
                    : null,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
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
      ),
    );
  }
}
