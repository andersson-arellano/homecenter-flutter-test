import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/core/dependencys/injection_get_it.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/products/products_bloc.dart';

class ProductPage extends StatefulWidget{
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductsBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Productos'),
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) { 
            return Center(
              child: Column(
                children: [
                  Text('Productos Page'),
                  TextButton(onPressed: (){
                      context.read<ProductsBloc>().add(
                        LoadProducts(page: 1, q: 'humedad'),
                      );
                  }, child: const Text("Test"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
