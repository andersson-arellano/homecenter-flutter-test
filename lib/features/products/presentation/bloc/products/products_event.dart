part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductsEvent {
  final int? page;
  final String? q;
  final bool reloadProductList;

  const LoadProducts({required this.page, this.q, this.reloadProductList = false});
}

class AddProductToCart extends ProductsEvent {
  final Product product;
  const AddProductToCart(this.product);
}

// OJO:
class ProductListLoadMoreProducts extends ProductsEvent {}
