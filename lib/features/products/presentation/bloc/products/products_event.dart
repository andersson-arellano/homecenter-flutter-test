part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductsEvent {
  final int? page;
  final String? q;

  const LoadProducts({required this.page, this.q});
}

class AddProductToCart extends ProductsEvent {
  final Product product;
  const AddProductToCart(this.product);
}

// OJO:
class ProductListLoadMoreProducts extends ProductsEvent {}
