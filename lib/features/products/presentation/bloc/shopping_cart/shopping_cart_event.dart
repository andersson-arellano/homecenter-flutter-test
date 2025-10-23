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

class ClearShoppingCartEvent extends ShoppingCartEvent {}

class IncrementQualityProductOnShoppingCartEvent extends ShoppingCartEvent {
  final ProductCart product;

  IncrementQualityProductOnShoppingCartEvent({required this.product});
}

class DecrementQualityProductOnShoppingCartEvent extends ShoppingCartEvent {
  final ProductCart product;

  DecrementQualityProductOnShoppingCartEvent({required this.product});
}
