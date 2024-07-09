import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  var filterC = TextEditingController();

  var productC = TextEditingController();

  var quantity = 0;
  final db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  //upload images file to firebase storage
  Future<String> uploadImage(String imagePath, String imageName) async {
    File image = File(imagePath);
    final imageRef = storageRef.child('images/$imageName');
    try {
      await imageRef.putFile(image);
      return await imageRef.getDownloadURL();
    } catch (err) {
      print('Error : $err');
      return '';
    }
  }

  //TODO: ADD Product
  void addProduct(
      String productName, String description, String imagePath, int price) {
    final product = <String, dynamic>{
      "name": productName,
      "description": description,
      "image": imagePath,
      "price": price,
    };
    try {
      db.collection('products').add(product).then((value) {
        print('Product Berhasil Ditambahkan dengan ID: ${value.id}');
      });
    } catch (err) {
      print('Error : $err');
    }
  }

  //TODO: Update Product
  void updateProduct(String docID, String productName, String description,
      String imagePath, int price) {
    final product = <String, dynamic>{
      "name": productName,
      "description": description,
      "image": imagePath,
      "price": price,
    };
    try {
      db.collection('products').doc(docID).update(product).then(
          (value) => print('Product Berhasil Diupdate dengan ID: $docID'));
    } catch (err) {
      print('Error : $err');
    }
  }

  //TODO: Delete Product
  void deleteProduct(String docID) {
    try {
      db
          .collection('products')
          .doc(docID)
          .delete()
          .then((value) => print('Product Berhasil Dihapus dengan ID: $docID'));
    } catch (err) {
      print('Error : $err');
    }
  }

  //TODO: Stream Product
  Stream<QuerySnapshot> get productStream =>
      db.collection('products').snapshots();

  //TODO: Get Data
  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = db.collection('products').doc(docID);
    return docRef.get();
  }
}
