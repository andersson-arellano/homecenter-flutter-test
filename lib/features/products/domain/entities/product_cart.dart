import 'package:homecenter_flutter/features/products/domain/entities/product.dart';

class ProductCart extends Product{
  final int quantity;

  const ProductCart({
    required this.quantity,
    required super.productId,
    required super.displayName,
    required super.price,
    required super.mediaUrls,
  });

  ProductCart copyWith({
    int? quantity,
    String? productId,
    String? displayName,
    String? price,
    List<String>? mediaUrls,
  }) {
    return ProductCart(
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
      displayName: displayName ?? this.displayName,
      price: price ?? this.price,
      mediaUrls: mediaUrls ?? this.mediaUrls,
    );
  }

  @override
  List<Object?> get props => [
    quantity,
    productId,
    displayName,
    price,
    mediaUrls,
  ];
}