import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/index.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:homecenter_flutter/features/products/domain/entities/product.dart';

part 'products_state.dart';
part 'products_event.dart';

// throttle to avoid multiple requests
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsState>{
  final GetProducts _getProducts; 

  ProductsBloc({
    required GetProducts getProducts
  }): 
    _getProducts = getProducts,
    super(ProductsInitial()
    ){
    on<LoadProducts>(_onLoadProducts,transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onLoadProducts(event, emit) async {
    emit(
      ProductsLoading(
        state.products,
        event.page ?? state.page,
        event.q ?? state.q,
      ),
    );

    try {
      final products = await _getProducts(
        page: event.page ?? state.page,
        q: event.q ?? state.q,
      );


      emit(
        ProductsLoaded(
          event.reloadProductList ? products : [...state.products, ...products],
          event.page ?? state.page,
          event.q ?? state.q,
        ),
      );
    } catch (e) {
      emit(
        ProductsError(
          state.products,
          event.page ?? state.page,
          event.q ?? state.q,
          e.toString(),
        ),
      );
    }
  }


  @override
  Future<void> close() {
    return super.close();
  }
}