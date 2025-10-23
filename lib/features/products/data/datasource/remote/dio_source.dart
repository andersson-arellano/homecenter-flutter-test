import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_drift_store/http_cache_drift_store.dart';
import 'package:path_provider/path_provider.dart';

class DioSource {
  DioSource({
    required Dio? dio,
    required String baseUrl,
  }): dio = dio ?? createDio(baseUrl){
    _initailizeCache();
  }


  static CacheOptions? _cacheOptions;
  final Dio dio;

  static Dio createDio(String baseUrl){
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 5000),
        sendTimeout: const Duration(milliseconds: 5000),
      )
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          assert(() {
            // ignore: avoid_print
            print(object);
            return true;
          }(), 'loggin is enable');
        },
      ),
    );
    return dio;
  }

  Future<void> _initailizeCache() async {
    if (_cacheOptions != null ) return;

    try{
      final cacheDir = await getTemporaryDirectory();
      final cacheStore = DriftCacheStore(databasePath: '${cacheDir.path}/http_cache.db');

      _cacheOptions = CacheOptions(
        store: cacheStore,
        policy: CachePolicy.forceCache,
        hitCacheOnErrorCodes: [500,304],
        maxStale: const Duration(days: 7),
        priority: CachePriority.high,
      );

      dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions!));
    }catch(e) {
      _cacheOptions = CacheOptions(store: MemCacheStore(), hitCacheOnErrorCodes: [500,304], maxStale: const Duration(days: 7));

      dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions!));
    }
  }

  Options buildCacheOptions ( Duration maxAge){
    if (_cacheOptions == null) {
      return CacheOptions(
        store: MemCacheStore(),
        policy: CachePolicy.forceCache,
        maxStale: maxAge,
        hitCacheOnErrorCodes: [500, 304],
      ).toOptions();
    }

    return CacheOptions(
      store: _cacheOptions!.store,
      maxStale: maxAge,
      policy: CachePolicy.forceCache,
      hitCacheOnErrorCodes: [500, 304],
      priority: CachePriority.high,
    ).toOptions();
  }

  Future<void> close() async {
    dio.clone();

    if (_cacheOptions?.store is DriftCacheStore){
      await (_cacheOptions!.store! as DriftCacheStore).close();
    }
  }

}