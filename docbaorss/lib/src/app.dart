import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DocBaoApp extends MaterialApp {
  DocBaoApp({Key? key})
      : super(
    key: key,
    title: 'Doc Bao Online',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: const AppBarTheme(color: kPrimaryColor),
      cupertinoOverrideTheme:
      const CupertinoThemeData(primaryColor: kPrimaryColor),
      textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.white),
      // accentColor: kPrimaryColor,
      primaryColor: kPrimaryColor,
    ),
    home: FirebaseAuthService.isSignIn
        ? const HomePage()
        : const SignInPage(),
  );

  static Future<void> initiate() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await AppData.initialize();
    // await FirebaseAuthService.signOut();
  }
}
