part of 'shopping_cart_bloc.dart';

abstract class ShoppingCartEvent {}

class AddProductToShoppingCartEvent extends ShoppingCartEvent {
  final Product product;

  AddProductToShoppingCartEvent({required this.product});
}

class RemoveProductFromShoppingCartEvent extends ShoppingCartEvent {
  final Product product;

  RemoveProductFromShoppingCartEvent({required this.product});
}

class GetShoppingCartEvent extends ShoppingCartEvent {}
