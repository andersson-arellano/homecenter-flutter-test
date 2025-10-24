import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/core/app.dart';
import 'package:homecenter_flutter/core/dependencys/injection_get_it.dart' as di;
import 'package:homecenter_flutter/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/shopping_cart/shopping_cart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<ProductsBloc>()),
        BlocProvider(create: (context) => di.sl<ShoppingCartBloc>()),
      ],
      child: const MainApp(),
    ),
  );
}