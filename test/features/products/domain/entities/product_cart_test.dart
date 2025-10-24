import 'package:flutter_test/flutter_test.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';

void main() {
  group('ProductCart', () {
    const base = ProductCart(
      quantity: 1,
      productId: 'id-1',
      displayName: 'Taladro X',
      price: '123.45',
      mediaUrls: ['https://example.com/a.png'],
    );

    const sameAsBase = ProductCart(
      quantity: 1,
      productId: 'id-1',
      displayName: 'Taladro X',
      price: '123.45',
      mediaUrls: ['https://example.com/a.png'],
    );

    test('constructor assigns fields correctly', () {
      expect(base.quantity, 1);
      expect(base.productId, 'id-1');
      expect(base.displayName, 'Taladro X');
      expect(base.price, '123.45');
      expect(base.mediaUrls, ['https://example.com/a.png']);
    });

    test('equality holds for same values (Equatable)', () {
      expect(base, equals(sameAsBase));
    });

    test('copyWith modifies chosen fields keeping others', () {
      final updated = base.copyWith(quantity: 2, displayName: 'Taladro X Pro');
      expect(updated.quantity, 2);
      expect(updated.displayName, 'Taladro X Pro');
      expect(updated.productId, base.productId);
      expect(updated.price, base.price);
      expect(updated.mediaUrls, base.mediaUrls);

      // copyWith without args returns an equal instance
      final clone = base.copyWith();
      expect(clone, equals(base));
    });
  });
}
