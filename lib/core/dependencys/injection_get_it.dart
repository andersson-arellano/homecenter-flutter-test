import 'package:get_it/get_it.dart';
import 'package:homecenter_flutter/features/products/data/datasource/remote/dio_source.dart';
import 'package:homecenter_flutter/features/products/data/datasource/remote/products_remote_source.dart';
import 'package:homecenter_flutter/features/products/data/repositories/products_repository_imple.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/index.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/index.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/products/products_bloc.dart';

/// Get It instance
final GetIt sl = GetIt.instance;

const String apiUrl = "https://www.homecenter.com.co/s/search/v1";

/// Init Get It
Future<void> init() async {
  // Dio
  sl.registerLazySingleton(
    ()=> DioSource.createDio(apiUrl)
  );

  // ! Products

  // datasoruces
  sl.registerLazySingleton(
    () => ProductsRemoteSource(dio: sl(), baseUrl: apiUrl)
  );

  // repositories
  sl.registerLazySingleton<ProductsRepository>(()=> ProductsRepositoryImple(sl()));
  
  // usecases
  sl.registerLazySingleton(()=> GetProducts(repository: sl()));

  // Bloc
  sl.registerFactory<ProductsBloc>(()=> ProductsBloc(
     getProducts: sl(),
  ));
}