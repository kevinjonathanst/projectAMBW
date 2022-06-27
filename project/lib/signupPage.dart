import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class signupPage extends StatefulWidget {
  final VoidCallback onclickLogin;
  const signupPage({Key? key, required this.onclickLogin}) : super(key: key);

  @override
  State<signupPage> createState() => _signupPage(
  );
}

class _signupPage extends State<signupPage> {
  final formKey = GlobalKey<FormState>();
  final emailSignup = TextEditingController();
  final passwordSignup = TextEditingController();

  Future SignUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailSignup.text.trim(),
        password: passwordSignup.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
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
                controller: emailSignup,
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
                controller: passwordSignup,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? "Enter a valid email"
                    : null,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  onPressed: SignUp,
                  icon: Icon(Icons.arrow_forward),
                  label: Text("Sign Up")),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.grey),
                      text: "Sudah punya akun? ",
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onclickLogin,
                        text: "Login",
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
