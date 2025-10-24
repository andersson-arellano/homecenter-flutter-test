import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/widgets/product_list_item.dart' show ProductListItem;
import 'package:homecenter_flutter/features/products/presentation/widgets/search_button.dart';
import 'package:homecenter_flutter/features/products/presentation/widgets/shopping_cart_button.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/shopping_cart/shopping_cart_bloc.dart';

class ProductPage extends StatefulWidget{
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ShoppingCartBloc>().add(GetShoppingCartEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Productos'),
          actions: [
            SearchButton()
          ],
        ),
        floatingActionButton: const ShoppingCartButton(),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          buildWhen: (previous, current) => previous.products != current.products,
          builder: (context, state) { 
            return switch(state){
              ProductsInitial() => const Center(child: Text('Products Initial')),
              ProductsError() => const Center(child: Text('Products Error')),
              ProductsState() => 
                state.q.isEmpty ||  state.products.isEmpty
                ? const Center(child: Text('No products found'))
                : ProductListItem(products: state.products),
            };
          },
        ),
    );
  }
}
