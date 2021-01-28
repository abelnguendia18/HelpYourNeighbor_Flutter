import 'package:firebase_auth/firebase_auth.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_your_neighbor/src/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AuthenticationService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference userCollection =
      _firestore.collection('users');

  static Future<bool> singIn({String email, String password}) async {
    bool temp;
    try {
      final result = await (_firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password));
      final User user = result.user;
      //return user;
      if (user != null) temp = true;
    } catch (e) {
      print(e);
      temp = false;
    }
    return temp;
  }

  static singUp(
      {String userName,
      String userTelNumber,
      String email,
      String password}) async {
    try {
      final result = await (_firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password));
      var userId = result.user.uid;
      await (userCollection.document(userId).setData({
        'userId': userId,
        'userName': userName,
        'userTelNumber': userTelNumber
      }));
      return result.user;
    } catch (e) {
      print(e);
      return;
    }
  }

// This method returns the download url, as soon as the upload is okay
  static Future<String> uploadImage(String userId) async {
    final _picker = ImagePicker();
    final _storage = FirebaseStorage.instance;
    PickedFile image;
    //select image
    image = await (_picker.getImage(source: ImageSource.gallery));
    var file = File(image.path);
    var ref = _storage.ref().child("images/${image.path}");
    if (image != null) {
      //upload to Firebase
      await ref.putFile(file);
      var url = await ref.getDownloadURL();
      //print("URL: $url");
      return url;
    } else {
      return null;
    }
  }

  static Future<String> getUserTelNumber(String userId) async {
    var result;
    try {
      DocumentSnapshot userModel =
          await _firestore.collection('users').doc(userId).get();
      result = userModel['userTelNumber'];
    } catch (e) {
      print(e);
      result = null;
    }

    return result;
  }
}
