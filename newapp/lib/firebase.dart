import 'package:flutter/material.dart';


class FirebaseA extends StatefulWidget {

  @override
  _FirebaseA createState() => _FirebaseA();
}
class _FirebaseA extends State<FirebaseA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NEWSAPP"),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text("Welcome To NewsApp",
              style: TextStyle( fontSize: 27,color: Colors.blueAccent,fontWeight: FontWeight.bold
              ),),
          ),
          SizedBox(height: 100.0,),
          Container(
            child: Text("Nếu bạn có tài khoản, vui lòng bấm vào nút đăng nhập",),
          ),
          Container(
            child: OutlineButton(
              child: Text("Đăng Nhập",
                style: TextStyle(
                  color: Color(0xFF2661FA),
                  fontSize: 16,
                ),
              ),
              color: Colors.blue,
              onPressed: () => _pushPage(context, login()),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          Container(
            child: Text("Nếu bạn chưa có tài khoản, vui lòng nhấp vào nút Đăng ký"),
          ),
          Container(
            child: OutlineButton(
              child: Text("Đăng kí",
                style: TextStyle(
                    color: Color(0xFF2661FA),
                    fontSize: 16),
                textAlign: TextAlign.left,
              ),
              color: Colors.blue,
              onPressed: () => _pushPage(context, Register()),
            ),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}