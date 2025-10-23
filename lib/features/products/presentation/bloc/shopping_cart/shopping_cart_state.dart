part of 'shopping_cart_bloc.dart';


class ShoppingCartState {
  final List<ProductCart> products;
  final String? error;

  factory ShoppingCartState.initial() => ShoppingCartState(products: [], error: null);

  factory ShoppingCartState.loading(List<ProductCart> products) =>
      ShoppingCartState(products: products, error: null);

  factory ShoppingCartState.success(List<ProductCart> products) =>
      ShoppingCartState(products: products, error: null);

  factory ShoppingCartState.failure(List<ProductCart> products, String error) =>
      ShoppingCartState(products: products, error: error);

  ShoppingCartState({required this.products, required this.error});
}
