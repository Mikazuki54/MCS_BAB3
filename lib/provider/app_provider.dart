import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AppProvider extends ChangeNotifier {
  final firebaseAuthentication = FirebaseAuth.instance;


  // METHOD LOGIN FIREBASE
  Future loginToApp(String username, String password) async {
    try {
      UserCredential userCredential = await firebaseAuthentication
          .signInWithEmailAndPassword(email: username, password: password);
      return userCredential;
    } catch (e) {
      throw Exception(e);
    }
  }

  // METHOD LOGOUT FIREBASE
  Future logoutAccount() async {
    await firebaseAuthentication.signOut();
  }
  
}
