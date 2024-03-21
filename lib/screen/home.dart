import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signInWithAnonymous();
          },
          child: Text('Sign in anonymously'),
        ),
      ),
    );
  }
}

Future<void> signInWithAnonymous() async {
  try {
    UserCredential _credential = await _firebaseAuth.signInAnonymously();
    if (_credential.user != null) {
      print('Signed in anonymously with UID: ${_credential.user!.uid}');
    }
  } catch (e) {
    print('Failed to sign in anonymously: $e');
  }
}
