import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/data/datasource/categories_datasoruce_impl.dart';
import 'package:ecommerce/data/datasource/products_datasource.dart';
import 'package:ecommerce/data/repository/categories_repository_impl.dart';
import 'package:ecommerce/data/repository/products_repository_impl.dart';
import 'package:ecommerce/domain/datasource/categories_datasource.dart';
import 'package:ecommerce/domain/datasource/products_datasource.dart';
import 'package:ecommerce/domain/model/categories_data_dto.dart';
import 'package:ecommerce/domain/model/categories_result_dto.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/domain/repository/categories_repository.dart';
import 'package:ecommerce/domain/repository/products_repository.dart';
import 'package:ecommerce/domain/usecases/categories_usecase.dart';
import 'package:ecommerce/domain/usecases/products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabViewModel extends Cubit<HomeTabViewState> {
  late ApiManager apiManager;
  late CategoriesRepository categoriesRepository;
  late CategoriesDataSource categoriesDataSource;
  late CategoriesUseCase categoriesUseCase;
  late ProductsRepository productsRepository;
  late ProductsDataSource productsDataSource;
  late ProductsUseCase productsUseCase;

  HomeTabViewModel() : super(HomeTabInitialState()) {
    apiManager = ApiManager();
    categoriesDataSource = CategoriesDataSourceImpl(apiManager);
    categoriesRepository = CategoriesRepositoryImpl(categoriesDataSource);
    categoriesUseCase = CategoriesUseCase(categoriesRepository);
    productsDataSource = productsDataSourceImpl(apiManager);
    productsRepository = ProductsRepositoryImpl(productsDataSource);
    productsUseCase = ProductsUseCase(productsRepository);
  }

  void getCategories() async {
    // emit(HomeTabLoadingState('Loading...'));
    var response = await categoriesUseCase.invoke();

    emit(HomeTabSuccessState(response.categoriesList!));
  }

  void getAllProducts() async {
    var response = await productsUseCase.invoke();

    emit(HomeTabProductsSuccess(response.data!));
  }

  void getUserFavorites() async {
    var response = await apiManager.getFavorite();

    emit(GetUserFavoritesSuccessState(products: response.data));
  }
}

abstract class HomeTabViewState {}

class HomeTabInitialState extends HomeTabViewState {}

class HomeTabLoadingState extends HomeTabViewState {
  String loadingMessage;

  HomeTabLoadingState(this.loadingMessage);
}

class HomeTabSuccessState extends HomeTabViewState {
  List<CategoriesDataDto> categories;

  HomeTabSuccessState(this.categories);
}

class HomeTabProductsSuccess extends HomeTabViewState {
  List<ProductsDataDto> products;

  HomeTabProductsSuccess(this.products);
}

class LoginFailState extends HomeTabViewState {
  String? failMessage;
  String? failContent;

  LoginFailState({this.failMessage, this.failContent});
}

class GetUserFavoritesSuccessState extends HomeTabViewState {
  List<ProductsDataDto>? products;

  GetUserFavoritesSuccessState({this.products});
}
