import 'package:ecommerce/domain/model/categories_data_dto.dart';
import 'package:flutter/material.dart';

class CategoriesListProvider extends ChangeNotifier {
  List<CategoriesDataDto> categories = [];

  void setCategoriesList(List<CategoriesDataDto> categories) {
    this.categories = categories;
    notifyListeners();
  }
}
