import 'package:newapp/login.dart';
import 'package:newapp/home.dart';  //used after user successfully completed process
import 'package:firebase_auth/firebase_auth.dart'; //used for authentication
import 'package:flutter/material.dart';

import 'home.dart';

class Register extends StatefulWidget {

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSuccess;
  String _userEmail;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _displayName,
                      decoration: const InputDecoration(labelText: 'Họ và tên'), //show one line to take user input
                      validator: (String value) {
                        if (value.isEmpty) { //check user enter someting or not
                          return 'Vui lòng nhập họ và tên';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Email không chính xác';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Mật khẩu'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Mật khẩu không chính xác';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: OutlineButton(
                        child: Text("Đăng kí",
                          style: TextStyle(
                            color: Color(0xFF2661FA),
                            fontSize: 16,
                          ),),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _registerAccount(); // funtion used to check your data is valid or not if valid pass that data to firebase and user to home or show a pop message
                          }
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        "Trở về đăng nhập",
                        style: TextStyle(fontSize: 13, color: Color(0XFF2661FA)),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
  void _registerAccount() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displayName.text);
      final user1 = _auth.currentUser;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(
          )));
    } else {
      _isSuccess = false;
    }
  }
}