import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/home.dart';

import 'home.dart';


class login extends StatefulWidget {
  @override
  _login createState() => _login();
}
class _login extends State<login> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            withEmailPassword(),
          ],
        );
      }),
    );
  }
  Widget withEmailPassword() {
    return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(''),
                  alignment: Alignment.center,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value.isEmpty) return 'Vui lòng nhập email';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Mật Khẩu'),
                  validator: (value) {
                    if (value.isEmpty) return 'Vui lòng nhập mật khẩu';
                    return null;
                  },
                  obscureText: true,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.center,
                  child: OutlineButton(
                    child: Text("Đăng Nhập",
                      style: TextStyle(
                        color: Color(0xFF2661FA),
                        fontSize: 16,
                      ),),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _signInWithEmailAndPassword();
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Quên mật khẩu?",
                    style: TextStyle(fontSize: 13, color: Color(0XFF2661FA)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomePage(
          user: user,
        );
      }));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Đăng nhập Email hoặc mật khẩu không đúng"),
      ));
    }
  }
  void _signOut() async {
    await _auth.signOut();
  }
}