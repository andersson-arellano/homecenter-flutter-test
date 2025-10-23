import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/widgets/my_search_delegate.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () async {
        final String? result = await showSearch(
          context: context,
          delegate: MySearchDelegate(
             context.read<ProductsBloc>().state.q,
          ),
        );
        // Update the state with the selected result, if any
        if (result != null && result.isNotEmpty) {
          if (result == context.read<ProductsBloc>().state.q) return;

          context.read<ProductsBloc>().add(
            LoadProducts(page: 1, q: result),
          );
        }
      },
    );
  }
}