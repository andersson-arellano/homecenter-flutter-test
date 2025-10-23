// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  displayName: json['displayName'] as String,
  mediaUrls: (json['mediaUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  productId: json['productId'] as String,
  price: ProductModel._extractPriceFromJson(json['prices'] as List?),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'displayName': instance.displayName,
      'mediaUrls': instance.mediaUrls,
      'prices': instance.price,
    };
