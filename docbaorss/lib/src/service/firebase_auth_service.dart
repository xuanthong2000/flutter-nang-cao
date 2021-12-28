import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthService {
  static final _auth = FirebaseAuth.instance;

  static String get userId => _auth.currentUser!.uid;

  static String get email => _auth.currentUser?.email ?? '';

  static bool get isSignIn => _auth.currentUser != null;

  static Future<UserCredential> signInUser(
      String email, String password) async {
    try {
      final _credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _credential;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Internet Connection Error';
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signUpUser(
      String email, String password) async {
    try {
      final _credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      } else {
        throw e.message ?? 'Internet Connection Error';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future signOut() async {
    await _auth.signOut();
  }
}
