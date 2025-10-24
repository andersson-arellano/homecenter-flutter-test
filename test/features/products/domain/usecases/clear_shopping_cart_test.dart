import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:homecenter_flutter/features/products/domain/repositories/shopping_cart_repository.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/clear_shopping_cart.dart';

class _MockShoppingCartRepository extends Mock implements ShoppingCartRepository {}

void main() {
  late _MockShoppingCartRepository repo;
  late ClearShoppingCart usecase;

  setUp(() {
    repo = _MockShoppingCartRepository();
    usecase = ClearShoppingCart(repository: repo);
  });

  test('calls repository.clearShoppingCart', () async {
    when(() => repo.clearShoppingCart()).thenAnswer((_) async {});

    await usecase();

    verify(() => repo.clearShoppingCart()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
