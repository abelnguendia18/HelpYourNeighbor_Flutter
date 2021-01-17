import 'package:firebase_auth/firebase_auth.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter/material.dart';

class AuthenticationService {

  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


 static singIn({String email, String password}) async {

   final result = await (_firebaseAuth.signInWithEmailAndPassword(email: email , password: password));
   final User user = result.user;
   return user;


  }

  Future<String> singUp({String email, String password}) {}
}
