import 'package:flutter/material.dart';
import 'package:assignment_2/helpers/dbhelper.dart';
import 'package:assignment_2/models/product.dart';

class Products extends ChangeNotifier {
  List<Product> _items = [];
  List<Product> _items_isfav = [];

  Future<List<Product>> get items async {
    var list = await DbHelper.fetchProducts();

    _items = list.map((item) => Product.fromMap(item)).toList();
    return _items;
  }

  Future<List<Product>> get isfavitems async {
    var lists = await DbHelper.fetchfav();
    _items_isfav = lists.map((items) => Product.fromMap(items)).toList();
    return _items_isfav;
  }

  int get totalNoItems => _items.length;

  void add(Product p) {
    DbHelper.insertProduct(p);
    notifyListeners();
  }

  void updateitem(Product p, int index) {
    DbHelper.updateProduct(p);
    notifyListeners();
  }

  void quantity(Product p, int index) {
    print("provider quantity: ${_items[index].quantity}");
    DbHelper.quantityProduct(p);
    notifyListeners();
  }

  void deletecart(Product p, int index) {
    print("provider quantity: ${_items[index].quantity}");
    DbHelper.deleteCart(p);
    notifyListeners();
  }

  void toggleFavorite(int index) {
    _items[index].isFavorite = _items[index].isFavorite;
    notifyListeners();
  }

  Product item(int index) => _items[index];
}
