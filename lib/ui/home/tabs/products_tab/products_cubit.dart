import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/data/datasource/products_datasource.dart';
import 'package:ecommerce/data/repository/products_repository_impl.dart';
import 'package:ecommerce/domain/datasource/products_datasource.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/domain/repository/products_repository.dart';
import 'package:ecommerce/domain/usecases/products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsViewState> {
  late ApiManager apiManager;
  late ProductsRepository productsRepository;
  late ProductsDataSource productsDataSource;
  ProductsCubit() : super(ProductsInitial()) {
    apiManager = ApiManager();
    productsDataSource = productsDataSourceImpl(apiManager);
    productsRepository = ProductsRepositoryImpl(productsDataSource);
  }

  void getProducts({String? category}) async {
    try {
      List<ProductsDataDto> currentProducts =
          state is ProductsLoaded ? (state as ProductsLoaded).products : [];
      emit(ProductsLoading());
      var response = await apiManager.getAllProducts(category: category);

      List<ProductsDataDto>? products =
          response.data?.map((product) => product.toProductsDataDto()).toList();

      emit(ProductsLoaded(products: [...currentProducts, ...products!]));
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }
}

abstract class ProductsViewState {}

class ProductsInitial extends ProductsViewState {}

class ProductsLoading extends ProductsViewState {}

class ProductsLoaded extends ProductsViewState {
  List<ProductsDataDto> products;
  ProductsLoaded({this.products = const []});
}

class ProductsError extends ProductsViewState {
  String? message;
  ProductsError({this.message});
}
