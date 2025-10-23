import 'package:json_annotation/json_annotation.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product{
  const ProductModel({
    required super.displayName,
    required super.mediaUrls,
    required super.productId,
    required String price,
  }): price = price,
    super(price: price);

  @JsonKey(fromJson: _extractPriceFromJson, name: "prices")  
  final String price;

  static _extractPriceFromJson(List<dynamic>? prices){
    return prices?.where((price)=> price['type'] == 'NORMAL').first['price'] ?? "";  
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  /// Convert DTO to domain entity
  Product toEntity() {
    return Product(
      displayName: displayName,
      mediaUrls: mediaUrls,
      price: price,
      productId: productId,
    );
  } 

}