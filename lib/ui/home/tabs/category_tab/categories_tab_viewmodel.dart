import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/data/datasource/categories_datasoruce_impl.dart';
import 'package:ecommerce/data/repository/categories_repository_impl.dart';
import 'package:ecommerce/domain/datasource/categories_datasource.dart';
import 'package:ecommerce/domain/model/categories_data_dto.dart';
import 'package:ecommerce/domain/repository/categories_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTabViewmodel extends Cubit<CategoriesTabViewState> {
  List<CategoriesDataDto> categories = [];
  late ApiManager _apiManager;
  late CategoriesDataSource _categoriesDataSource;
  late CategoriesRepository _categoriesRepository;
  CategoriesTabViewmodel() : super(CategoriesTabInitial()) {
    _apiManager = ApiManager();
    _categoriesDataSource = CategoriesDataSourceImpl(_apiManager);
    _categoriesRepository = CategoriesRepositoryImpl(_categoriesDataSource);
  }

  void getCategories({required String id}) async {
    emit(CategoriesTabLoading());

    try {
      var categories = await _categoriesRepository.getSubCategories(id: id);
      emit(CategoriesTabLoaded(categories: categories.categoriesList!));
    } catch (e) {
      emit(CategoriesTabError(errorMessage: e.toString()));
    }
  }
}

abstract class CategoriesTabViewState {}

class CategoriesTabInitial extends CategoriesTabViewState {}

class CategoriesTabLoading extends CategoriesTabViewState {}

class CategoriesTabLoaded extends CategoriesTabViewState {
  List<CategoriesDataDto> categories = [];

  CategoriesTabLoaded({required this.categories});
}

class CategoriesTabError extends CategoriesTabViewState {
  String errorMessage = 'Error';

  CategoriesTabError({required this.errorMessage});
}
