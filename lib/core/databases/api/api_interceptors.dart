import 'package:dio/dio.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // اجلب التوكين من الـ cache
    final token = CacheHelper().getData(key: ApiKey.access);
    if (token != null) {
      // أضف Authorization header بالشكل الذي تتوقعه الـ DRF
      options.headers['Authorization'] = 'JWT $token';
    }

    // إذا خزّنت مؤخراً X-Schema في الكاش:
    final schema = CacheHelper().getData(key: ApiKey.xSchema);
    if (schema != null) {
      options.headers['x-schema'] = schema;
    }
    
    super.onRequest(options, handler);
  }
}
