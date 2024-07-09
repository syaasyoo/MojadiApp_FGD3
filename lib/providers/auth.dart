import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  //Text Editing Controller
  var emailC = TextEditingController();
  var passwordC = TextEditingController();
  var nameC = TextEditingController();
  //Firebase Things
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref();
  User get user => _auth.currentUser!;
  String userRole = '';
  //TODO: Register User
  Future<bool> registerUser(
      String email, String password, String name, String imageURL) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      user!.updateDisplayName(name);
      user.updatePhotoURL(imageURL);
      await _db.collection('users').doc(user.uid).set({
        'email': email,
        'role': 'user',
      });
      print('Register Successfully');
      return true;
    } catch (err) {
      print('Error : $err');
      return false;
    }
  }

  //TODO: Login User
  Future<bool> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('Login Successfully');
      return true;
    } catch (err) {
      print('Error : $err');
      return false;
    }
  }

  //TODO: Logout User
  Future<bool> logoutUser() async {
    await _auth.signOut();
    print('Logout Successfully');
    return true;
  }

  //TODO: Get user role
  Future<String> getUserRole() async {
    final user = _auth.currentUser;
    final doc = await _db.collection('users').doc(user!.uid).get();
    return doc.get('role');
  }

  //TODO: Check User Login
  bool isUserLogin() {
    final user = _auth.currentUser;
    return user != null;
  }

  //TODO: Upload Image
  Future<String> uploadImage(String imagePath, String imageName) async {
    File image = File(imagePath);
    final imageRef = _storageRef.child('users/$imageName');
    try {
      await imageRef.putFile(image);
      return await imageRef.getDownloadURL();
    } catch (err) {
      print('Error : $err');
      return '';
    }
  }
}
