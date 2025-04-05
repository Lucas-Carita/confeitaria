import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(String name, double price, String image) {
    _items.add({'name': name, 'price': price, 'image': image, 'quantity': 1});
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  double get total {
    return _items.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }
}
