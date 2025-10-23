part of 'products_bloc.dart';


abstract class ProductsState extends Equatable{
  const ProductsState({
    required this.products,
    this.page = 1,
    this.q= '',
  });

  final List<Product> products;
  final int page;
  final String q;

  @override
  List<Object> get props => [ products, page, q];
}

class ProductsInitial extends ProductsState {
  ProductsInitial() : super(products: [], page: 1, q: '');
}

class ProductsLoading extends ProductsState {
  ProductsLoading(List<Product> products, int page, String q)
    : super(products: products, page: 1, q: q);

  ProductsLoading copyWith({
    List<Product>? products,
    int? page,
    String? q,
  }) {
    return ProductsLoading(
      products ?? this.products,
      page ?? this.page,
      q ?? this.q,
    );
  }
}

class ProductsLoaded extends ProductsState {
  ProductsLoaded(List<Product> products, int page, String q)
    : super(products: products, page: page, q: q);

  ProductsLoaded copyWith({
    List<Product>? products,
    int? page,
    String? q,
  }) {
    return ProductsLoaded(
      products ?? this.products,
      page ?? this.page,
      q ?? this.q,
    );
  }
}

class ProductsError extends ProductsState {
  ProductsError(
    List<Product> products,
    int page,
    String q,
    this.message,
  ) : super(products: products, page: page, q: q);

  final String message;
  ProductsError copyWith({
    List<Product>? products,
    int? page,
    String? q,
    String? message,
  }) {
    return ProductsError(
      products ?? this.products,
      page ?? this.page,
      q ?? this.q,
      message ?? this.message,
    );
  }
}
