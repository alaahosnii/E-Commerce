import 'package:flutter/material.dart';

class UserFavoritesProvider extends ChangeNotifier {
  List<String> favorites = [];

  void addFavorite({String? productId}) {
    favorites.add(productId!);
    notifyListeners();
  }

  void removeFromFavorite({required List<String> updatedFavorites}) {
    favorites = updatedFavorites;
    notifyListeners();
  }
}
