import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/widgets/product_item.dart';

class ProductListItem extends StatefulWidget{
  const ProductListItem({super.key, required this.products});

  final List<Product> products;

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ProductListItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the products list has changed, scroll to the top
    if (oldWidget.products != widget.products) {
      _scrollToTop();
    }
  }

  void _scrollToTop() {
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    // When hasClients is true and the scroll position is at the end of the list
    if (
      _controller.hasClients && 
      _controller.offset >= _controller.position.maxScrollExtent*0.9  
      ) {
      // Load more products
      context.read<ProductsBloc>().add(
        LoadProducts(
          page: context.read<ProductsBloc>().state.page + 1,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16
      ),
      itemBuilder: (context, index) {
        if(index >= widget.products.length){
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ProductItem(
            key: ValueKey(widget.products[index].productId),
            product: widget.products[index],
          ),
        ); 
        }, 
      itemCount: widget.products.length + 1
      );
  }
}