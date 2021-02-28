import 'package:firebase_auth/firebase_auth.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_your_neighbor/src/models/announcement_model.dart';
import 'package:help_your_neighbor/src/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AuthenticationService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference userCollection = firestore.collection('users');
  static CollectionReference announcementCollection =
      firestore.collection('announcements');

  static Future<String> getCurrentUserId() async {
    String uid = await firebaseAuth.currentUser.uid;

    return uid;
  }

  static Future<String> saveAnnouncement(Announcement announcement) async {
    String result;
    Map<String, dynamic> data = {
      "category": announcement.categoryAnnouncement,
      "description": announcement.descriptionAnnouncement,
      "imagePath": announcement.imagePath,
      "ownerAddress": announcement.ownerAddress,
      "ownerId": announcement.ownerId,
      "ownerPhoneNumber": announcement.ownerPhoneNumber,
      "price": announcement.priceAnnouncement,
      "status": announcement.statusAnnouncement,
      "isFavorite": announcement.isFavorite
    };
    try {
      await announcementCollection.add(data);
      result = "ok";
    } catch (e) {
      result = "ko";
      print(e);
    }

    return result;
  }

  static Future<bool> singIn({String email, String password}) async {
    bool temp;
    try {
      final result = await (firebaseAuth.signInWithEmailAndPassword(
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
      final result = await (firebaseAuth.createUserWithEmailAndPassword(
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

  static Future<void> logout() async {
    await firebaseAuth.signOut();
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
          await firestore.collection('users').doc(userId).get();
      result = userModel['userTelNumber'];
    } catch (e) {
      print(e);
      result = null;
    }

    return result;
  }

  static Future<String> getUsername(String userId) async {
    var result;
    try {
      DocumentSnapshot userModel =
          await firestore.collection('users').doc(userId).get();
      result = userModel['userName'];
    } catch (e) {
      print(e);
      result = null;
    }

    return result;
  }

  static Future<void> updateFavoriteState(
      String documentId, String newValue) async {
    try {
      await firestore
          .collection('announcements')
          .doc(documentId)
          .update({"isFavorite": newValue});
    } catch (e) {
      print(e);
    }
  }

  static Future getAnnouncementsList() async {
    QuerySnapshot query = await announcementCollection.get();

    return query.docs;
  }

  static Future getAnnouncementsListOfCurrentUser(String userId) async {
    QuerySnapshot query = await announcementCollection
        .where("ownerId", isEqualTo: "$userId")
        .get();

    return query.docs;
  }

  static Future getFavoritesList() async {
    QuerySnapshot query =
        await announcementCollection.where("isFavorite", isEqualTo: "ja").get();

    return query.docs;
  }
}
