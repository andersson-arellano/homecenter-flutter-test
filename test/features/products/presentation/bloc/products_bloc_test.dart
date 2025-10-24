import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/get_products.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProducts extends Mock implements GetProducts {}

void main() {
  late MockGetProducts mockGetProducts;

  const p1 = Product(
    productId: '1',
    displayName: 'Prod 1',
    price: '100',
    mediaUrls: ['https://example.com/1.png'],
  );
  const p2 = Product(
    productId: '2',
    displayName: 'Prod 2',
    price: '200',
    mediaUrls: ['https://example.com/2.png'],
  );

  setUp(() {
    mockGetProducts = MockGetProducts();
  });

  group('ProductsBloc', () {
    test('initial state is ProductsInitial', () {
      final bloc = ProductsBloc(getProducts: mockGetProducts);
      expect(bloc.state, isA<ProductsInitial>());
      bloc.close();
    });

    blocTest<ProductsBloc, ProductsState>(
      'emits [ProductsLoading, ProductsLoaded] on successful initial load (reloadProductList: true)',
      build: () {
        when(() => mockGetProducts.call(q: '', page: 1))
            .thenAnswer((_) async => [p1]);
        return ProductsBloc(getProducts: mockGetProducts);
      },
      act: (bloc) => bloc.add(const LoadProducts(page: 1, q: '', reloadProductList: true)),
      expect: () => [
        isA<ProductsLoading>()
            .having((s) => s.q, 'q', ''),
        isA<ProductsLoaded>()
            .having((s) => s.products, 'products', [p1])
            .having((s) => s.page, 'page', 1)
            .having((s) => s.q, 'q', ''),
      ],
      verify: (_) {
        verify(() => mockGetProducts.call(q: '', page: 1)).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'paginates and appends when reloadProductList is false',
      build: () {
        when(() => mockGetProducts.call(q: '', page: 1))
            .thenAnswer((_) async => [p1]);
        when(() => mockGetProducts.call(q: '', page: 2))
            .thenAnswer((_) async => [p2]);
        return ProductsBloc(getProducts: mockGetProducts);
      },
      act: (bloc) async {
        bloc.add(const LoadProducts(page: 1, q: '', reloadProductList: true));
        await Future<void>.delayed(const Duration(milliseconds: 150));
        bloc.add(const LoadProducts(page: 2, q: '', reloadProductList: false));
      },
      expect: () => [
        isA<ProductsLoading>()
            .having((s) => s.products.length, 'len', 0),
        isA<ProductsLoaded>()
            .having((s) => s.products, 'products', [p1])
            .having((s) => s.page, 'page', 1),
        isA<ProductsLoading>()
            .having((s) => s.products, 'existing products', [p1]),
        isA<ProductsLoaded>()
            .having((s) => s.products, 'products', [p1, p2])
            .having((s) => s.page, 'page', 2),
      ],
      verify: (_) {
        verify(() => mockGetProducts.call(q: '', page: 1)).called(1);
        verify(() => mockGetProducts.call(q: '', page: 2)).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'changes query and reloads list (resets items)',
      build: () {
        when(() => mockGetProducts.call(q: 'a', page: 1))
            .thenAnswer((_) async => [p1]);
        when(() => mockGetProducts.call(q: 'b', page: 1))
            .thenAnswer((_) async => [p2]);
        return ProductsBloc(getProducts: mockGetProducts);
      },
      act: (bloc) async {
        bloc.add(const LoadProducts(page: 1, q: 'a', reloadProductList: true));
        await Future<void>.delayed(const Duration(milliseconds: 150));
        bloc.add(const LoadProducts(page: 1, q: 'b', reloadProductList: true));
      },
      expect: () => [
        isA<ProductsLoading>().having((s) => s.q, 'q', 'a'),
        isA<ProductsLoaded>()
            .having((s) => s.products, 'products', [p1])
            .having((s) => s.q, 'q', 'a'),
        isA<ProductsLoading>().having((s) => s.q, 'q', 'b'),
        isA<ProductsLoaded>()
            .having((s) => s.products, 'products', [p2])
            .having((s) => s.q, 'q', 'b'),
      ],
      verify: (_) {
        verify(() => mockGetProducts.call(q: 'a', page: 1)).called(1);
        verify(() => mockGetProducts.call(q: 'b', page: 1)).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits [ProductsLoading, ProductsError] on failure',
      build: () {
        when(() => mockGetProducts.call(q: '', page: 1))
            .thenThrow(Exception('network error'));
        return ProductsBloc(getProducts: mockGetProducts);
      },
      act: (bloc) => bloc.add(const LoadProducts(page: 1, q: '', reloadProductList: true)),
      expect: () => [
        isA<ProductsLoading>()
            .having((s) => s.q, 'q', ''),
        isA<ProductsError>()
            .having((s) => s.q, 'q', '')
            .having((s) => s.message, 'message', contains('network error')),
      ],
      verify: (_) {
        verify(() => mockGetProducts.call(q: '', page: 1)).called(1);
      },
    );
  });
}