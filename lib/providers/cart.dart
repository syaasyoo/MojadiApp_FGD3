import 'package:fgd_2/models/cart_item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  bool selectedAll = false;

  Map<String, CartItem> get items => _items;

  int get totalItem {
    return _items.length;
  }

  //get price total when selected is true
  int get selectedTotal {
    var total = 0;
    _items.forEach((key, value) {
      if (value.selected) {
        total += value.qty * value.price.toInt();
      }
    });
    return total;
  }

  void addCart(
      String productID, String name, double price, int qty, String imagePath) {
    if (_items.containsKey(productID)) {
      //! jika productID sudah tersedia
      _items.update(
          productID,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              qty: value.qty + qty,
              selected: false,
              imagePath: value.imagePath));
    } else {
      //! nambah productID baru
      _items.putIfAbsent(
          productID,
          () => CartItem(
              id: productID,
              title: name,
              price: price,
              qty: qty,
              selected: false,
              imagePath: imagePath));
    }
    notifyListeners();
  }

  void deleteItem(String productID) {
    _items.removeWhere((key, value) => value.id == productID);
    notifyListeners();
  }

  void changeSelected(String productID) {
    _items.update(
        productID,
        (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              qty: value.qty,
              selected: !value.selected,
              imagePath: value.imagePath,
            ));
    notifyListeners();
  }

  void addQty(String productID) {
    _items.update(
        productID,
        (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              qty: value.qty + 1,
              selected: value.selected,
              imagePath: value.imagePath,
            ));
    notifyListeners();
  }

  void decreaseQty(String productID) {
    _items.update(
        productID,
        (value) => value.qty > 1
            ? CartItem(
                id: value.id,
                title: value.title,
                price: value.price,
                qty: value.qty - 1,
                selected: value.selected,
                imagePath: value.imagePath,
              )
            : CartItem(
                id: value.id,
                title: value.title,
                price: value.price,
                qty: value.qty,
                selected: value.selected,
                imagePath: value.imagePath,
              ));
    notifyListeners();
  }

  void selectAll() {
    selectedAll = !selectedAll;
    _items.updateAll((key, value) => CartItem(
        id: value.id,
        title: value.title,
        price: value.price,
        qty: value.qty,
        selected: selectedAll,
        imagePath: value.imagePath));
    notifyListeners();
  }
}
