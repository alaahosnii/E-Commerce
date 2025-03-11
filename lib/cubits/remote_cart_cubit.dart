import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/data/api/cart_response/cart_response.dart';
import 'package:ecommerce/data/datasource/products_datasource.dart';
import 'package:ecommerce/data/repository/products_repository_impl.dart';
import 'package:ecommerce/domain/datasource/products_datasource.dart';
import 'package:ecommerce/domain/repository/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteCartCubit extends Cubit<RemoteCartState> {
  late ApiManager apiManager;
  late ProductsRepository productsRepository;
  late ProductsDataSource productsDataSource;
  RemoteCartCubit() : super(RemoteCartInitial()) {
    apiManager = ApiManager();
    productsDataSource = productsDataSourceImpl(apiManager);
    productsRepository = ProductsRepositoryImpl(productsDataSource);
  }

  void addToCart({String? productId}) async {
    print("object");
    try {
      emit(AddToRemoteCartLoading());

      var repsonse = await apiManager.addToCart(productId: productId);
      emit(AddToRemoteCartSuccess(addToCartResponse: repsonse));
    } catch (e) {
      print("error: ${e.toString()}");
      emit(AddToRemoteCartError(errorMessage: e.toString()));
    }
  }

  void getCart() async {
    try {
      emit(GetRemoteCartLoading());

      var response = await apiManager.getUserCart();

      emit(GetRemoteCartSuccess(cartResponse: response));
    } catch (e) {
      emit(GetRemoteCartError(errorMessage: e.toString()));
    }
  }

  void deleteFromCart({String? productId}) async {
    try {
      emit(DeleteFromRemoteCartLoadingState());
      var response = await apiManager.deleteFromCart(id: productId);
      emit(DeleteFromRemoteCartSuccessState(cartResponse: response));
    } catch (e) {
      print("error: ${e.toString()}");
      emit(DeleteFromCartErrorState(message: e.toString()));
    }
  }

  void updateProductQuantity({String? id, String? quantity}) async {
    try {
      emit(UpdateProductQuantityLoadingState());
      var response =
          await apiManager.updateProductQuantity(id: id, quantity: quantity);
      emit(UpdateProductQuantitySuccessState(cartResponse: response));
    } catch (e) {
      print("error: ${e.toString()}");
      emit(UpdateProductQuantityErrorState(message: e.toString()));
    }
  }
}

abstract class RemoteCartState {}

class RemoteCartInitial extends RemoteCartState {}

class AddToRemoteCartLoading extends RemoteCartState {}

class AddToRemoteCartSuccess extends RemoteCartState {
  CartResponse? addToCartResponse;

  AddToRemoteCartSuccess({this.addToCartResponse});
}

class AddToRemoteCartError extends RemoteCartState {
  String? errorMessage;

  AddToRemoteCartError({this.errorMessage});
}

class GetRemoteCartLoading extends RemoteCartState {}

class GetRemoteCartSuccess extends RemoteCartState {
  CartResponse? cartResponse;

  GetRemoteCartSuccess({this.cartResponse});
}

class GetRemoteCartError extends RemoteCartState {
  String? errorMessage;

  GetRemoteCartError({this.errorMessage});
}

class DeleteFromRemoteCartSuccessState extends RemoteCartState {
  CartResponse? cartResponse;

  DeleteFromRemoteCartSuccessState({this.cartResponse});
}

class DeleteFromCartErrorState extends RemoteCartState {
  String? message;

  DeleteFromCartErrorState({this.message});
}

class DeleteFromRemoteCartLoadingState extends RemoteCartState {}

class UpdateProductQuantityErrorState extends RemoteCartState {
  String? message;

  UpdateProductQuantityErrorState({this.message});
}

class UpdateProductQuantityLoadingState extends RemoteCartState {}

class UpdateProductQuantitySuccessState extends RemoteCartState {
  CartResponse? cartResponse;

  UpdateProductQuantitySuccessState({this.cartResponse});
}
