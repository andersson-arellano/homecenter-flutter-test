import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/index.dart';

part 'shopping_cart_state.dart';
part 'shopping_cart_event.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  final ClearShoppingCart _clearShoppingCart;
  final RemoveProductFromShoppingCart _removeProductFromShoppingCart;
  final AddProductToShoppingCart _addProductToShoppingCart;
  final GetAllProductsOnShoppingCart _getAllProductsOnShoppingCart;
  final UpdateQualityProductOnShoppingCart _updateQualityProductOnShoppingCart;

  ShoppingCartBloc({
    required ClearShoppingCart clearShoppingCart,
    required RemoveProductFromShoppingCart removeProductFromShoppingCart,
    required AddProductToShoppingCart addProductToShoppingCart,
    required GetAllProductsOnShoppingCart getAllProductsOnShoppingCart,
    required UpdateQualityProductOnShoppingCart updateQualityProductOnShoppingCart,
  })
    : _clearShoppingCart = clearShoppingCart,
    _removeProductFromShoppingCart = removeProductFromShoppingCart,
    _addProductToShoppingCart = addProductToShoppingCart,
    _getAllProductsOnShoppingCart = getAllProductsOnShoppingCart,
    _updateQualityProductOnShoppingCart = updateQualityProductOnShoppingCart,
      super(ShoppingCartState.initial()){
    on<GetShoppingCartEvent>(_onGetShoppingCart);
    on<AddProductToShoppingCartEvent>(_onAddProductToShoppingCart);
    on<RemoveProductFromShoppingCartEvent>(_onRemoveProductFromShoppingCart);
    on<ClearShoppingCartEvent>(_onClearShoppingCart);
    on<IncrementQualityProductOnShoppingCartEvent>(_onIncrementQualityProductOnShoppingCart);
    on<DecrementQualityProductOnShoppingCartEvent>(_onDecrementQualityProductOnShoppingCart);
  }

  // Event handler for GetShoppingCartEvent
  _onGetShoppingCart(event, emit) async {
    try{
      final productsCart = await _getAllProductsOnShoppingCart();
      emit(ShoppingCartState.success(productsCart));
    }catch(e){
      emit(ShoppingCartState.failure(state.products, e.toString()));
    }
  }

  // Event handler for AddProductToShoppingCartEvent
  _onAddProductToShoppingCart(event, emit) async {
    try{
      await _addProductToShoppingCart(event.product);
      emit(ShoppingCartState.success(state.products));
    }catch(e){
      emit(ShoppingCartState.failure(state.products, e.toString()));
    }
  }

  // Event handler for RemoveProductFromShoppingCartEvent
  _onRemoveProductFromShoppingCart(event, emit) async {
    try{
      await _removeProductFromShoppingCart(event.product);
      emit(ShoppingCartState.success(await _getAllProductsOnShoppingCart()));
    }catch(e){
      emit(ShoppingCartState.failure(state.products, e.toString()));
    }
  }

  // Event handler for ClearShoppingCartEvent
  _onClearShoppingCart(event, emit) async {
    try{
      await _clearShoppingCart();
      emit(ShoppingCartState.success([]));
    }catch(e){
      emit(ShoppingCartState.failure(state.products, e.toString()));
    }
  } 

  // Event handler for IncrementQualityProductOnShoppingCartEvent
  _onIncrementQualityProductOnShoppingCart(event, emit) async {
    try{
      final product = event.product.copyWith(quantity: event.product.quantity + 1);
      await _updateQualityProductOnShoppingCart(product);
      emit(ShoppingCartState.success(await _getAllProductsOnShoppingCart()));
    }catch(e){
      emit(ShoppingCartState.failure(state.products, e.toString()));
    }
  }

  // Event handler for DecrementQualityProductOnShoppingCartEvent
  _onDecrementQualityProductOnShoppingCart(event, emit) async {
    try{
      final product = event.product.copyWith(quantity: event.product.quantity - 1);
      await _updateQualityProductOnShoppingCart(product);
      emit(ShoppingCartState.success(await _getAllProductsOnShoppingCart()));
    }catch(e){
      emit(ShoppingCartState.failure(state.products, e.toString()));
    }
  }
}