
import 'package:equatable/equatable.dart';

class Product extends Equatable {
 
  const Product({
    required this.productId,
    required this.displayName,
    required this.price,
    required this.mediaUrls,
  });

  final String productId;

  final String price;

  final String displayName;

  final List<String> mediaUrls;

  @override
  List<Object?> get props => [
    productId,
    price,
    displayName,
    mediaUrls,
  ];
}