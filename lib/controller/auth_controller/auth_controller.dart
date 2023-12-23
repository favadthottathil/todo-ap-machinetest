import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final _isLoading = false.obs;

  Rx<Stream<User?>> stream() => _firebaseAuth.authStateChanges().obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

  Future<String> logOut() async {
    try {
      await _firebaseAuth.signOut();

      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isLoading.value = false;

      return Future.value(ex.message);
    }
  }

  Future<String> signIn(String email, String password) async {
    _isLoading.value = true;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isLoading.value = false;

      return Future.value(ex.message);
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());

      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isLoading.value = false;

      return Future.value(ex.message);
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      

      _isLoading.value = true;

      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());

      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isLoading.value = false;
      return Future.value(ex.message);
    }
  }
}
