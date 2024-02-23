import 'package:flutter/material.dart';
import 'package:assignment_2/models/cartitem.dart';

class CartItems extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalNoItems => _items.length;

  void add(CartItem cartItem) {
    //_items List<CartItem> CartItem: code, quantity
    var codeList = _items.map((item) => item.code).toList();
    var index = codeList.indexOf(cartItem.code);
    if (index < 0) {
      _items.add(cartItem);
    } else {
      _items[index].quantity++;
    }
    notifyListeners();
  }
}
