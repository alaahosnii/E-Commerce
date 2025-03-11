import 'package:ecommerce/data/add_to_favorite_response.dart';
import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesTabCubit extends Cubit<FavoritesTabState> {
  ApiManager apiManager = ApiManager();
  FavoritesTabCubit() : super(FavoritesTabInitial());

  void getFavorite() async {
    emit(FavoritesTabLoading());

    try {
      var response = await apiManager.getFavorite();
      emit(FavoritesTabLoaded(favorites: response.data));
    } catch (e) {
      emit(FavoritesTabError(errorMessage: e.toString()));
    }
  }

  void addToFavorite({String? productId}) async {
    try {
      emit(AddToFavoriteLoading());
      var response = await apiManager.addToFavorite(productId: productId);
      emit(AddToFavoriteSuccess(addToFavoriteResponse: response));
      print("state from cubit: $state");
    } catch (e) {
      emit(AddToFavoriteError(errorMessage: e.toString()));
    }
  }

  void removeFromFavorite({String? productId}) async {
    try {
      emit(RemoveFromFavoriteLoading());
      var response = await apiManager.removeFromFavorite(productId: productId);
      emit(RemoveFromFavoriteSuccess(addToFavoriteResponse: response));
    } catch (e) {
      emit(RemoveFromFavoriteError(errorMessage: e.toString()));
    }
  }
}

abstract class FavoritesTabState {}

class FavoritesTabInitial extends FavoritesTabState {}

class FavoritesTabLoaded extends FavoritesTabState {
  List<ProductsDataDto>? favorites;

  FavoritesTabLoaded({this.favorites});
}

class FavoritesTabError extends FavoritesTabState {
  String? errorMessage;

  FavoritesTabError({this.errorMessage});
}

class FavoritesTabLoading extends FavoritesTabState {}

class AddToFavoriteLoading extends FavoritesTabState {}

class AddToFavoriteSuccess extends FavoritesTabState {
  AddToFavoriteResponse? addToFavoriteResponse;

  AddToFavoriteSuccess({this.addToFavoriteResponse});
}

class AddToFavoriteError extends FavoritesTabState {
  String? errorMessage;

  AddToFavoriteError({this.errorMessage});
}

class RemoveFromFavoriteSuccess extends FavoritesTabState {
  AddToFavoriteResponse? addToFavoriteResponse;

  RemoveFromFavoriteSuccess({this.addToFavoriteResponse});
}

class RemoveFromFavoriteError extends FavoritesTabState {
  String? errorMessage;

  RemoveFromFavoriteError({this.errorMessage});
}

class RemoveFromFavoriteLoading extends FavoritesTabState {}
