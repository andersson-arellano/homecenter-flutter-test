import 'package:flutter_test/flutter_test.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';

void main() {
  group('Product', () {
    const productA = Product(
      productId: 'id-1',
      displayName: 'Taladro X',
      price: '123.45',
      mediaUrls: ['https://example.com/a.png'],
    );

    const productAClone = Product(
      productId: 'id-1',
      displayName: 'Taladro X',
      price: '123.45',
      mediaUrls: ['https://example.com/a.png'],
    );

    const productB = Product(
      productId: 'id-2',
      displayName: 'Taladro Y',
      price: '123.45',
      mediaUrls: ['https://example.com/a.png'],
    );

    test('constructor assigns fields correctly', () {
      expect(productA.productId, 'id-1');
      expect(productA.displayName, 'Taladro X');
      expect(productA.price, '123.45');
      expect(productA.mediaUrls, ['https://example.com/a.png']);
    });

    test('equality holds for same values (Equatable)', () {
      expect(productA, equals(productAClone));
    });

    test('inequality when at least one field differs', () {
      expect(productA, isNot(equals(productB))); // productId and displayName differ
    });
  });
}
