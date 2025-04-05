import 'package:flutter/material.dart';

class FavoriteController extends ChangeNotifier {
  final List<Map<String, dynamic>> _favoriteItems = [];

  List<Map<String, dynamic>> get favoriteItems => _favoriteItems;

  void toggleFavorite(Map<String, dynamic> product) {
    if (_favoriteItems.any((item) => item['name'] == product['name'])) {
      _favoriteItems.removeWhere((item) => item['name'] == product['name']);
    } else {
      _favoriteItems.add({...product});
    }
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> product) {
    return _favoriteItems.any((item) => item['name'] == product['name']);
  }
}
