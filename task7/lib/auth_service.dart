import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // GOOGLE SIGN-IN
  Future<User?> signInWithGoogle() async {
    final googleProvider = GoogleAuthProvider();
    final userCredential = kIsWeb
        ? await _auth.signInWithPopup(googleProvider)
        : await _auth.signInWithProvider(googleProvider);
    return userCredential.user;
  }

  // EMAIL/PASSWORD REGISTER
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print("Registration error: $e");
      return null;
    }
  }

  // EMAIL/PASSWORD LOGIN
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get userStream => _auth.authStateChanges();
}