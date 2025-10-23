import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/index.dart';

part 'shopping_cart_state.dart';
part 'shopping_cart_event.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  final ClearShoppingCart _clearShoppingCart;
  final RemoveProductFromShoppingCart _removeProductFromShoppingCart;
  final AddProductToShoppingCart _addProductToShoppingCart;
  final GetAllProductsOnShoppingCart _getAllProductsOnShoppingCart;

  ShoppingCartBloc({
    required ClearShoppingCart clearShoppingCart,
    required RemoveProductFromShoppingCart removeProductFromShoppingCart,
    required AddProductToShoppingCart addProductToShoppingCart,
    required GetAllProductsOnShoppingCart getAllProductsOnShoppingCart,
  })
    : _clearShoppingCart = clearShoppingCart,
    _removeProductFromShoppingCart = removeProductFromShoppingCart,
    _addProductToShoppingCart = addProductToShoppingCart,
    _getAllProductsOnShoppingCart = getAllProductsOnShoppingCart,
      super(ShoppingCartState.initial()){
    //on<GetShoppingCartEvent>(_onGetShoppingCart);
    //on<AddProductToShoppingCartEvent>(_onAddProductToShoppingCart);
    //on<RemoveProductFromShoppingCartEvent>(_onRemoveProductFromShoppingCart);
  }
}