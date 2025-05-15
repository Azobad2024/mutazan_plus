// lib/core/databases/api/dio_consumer.dart

import 'package:dio/dio.dart';
import 'package:mutazan_plus/core/databases/api/api_interceptors.dart';
import 'api_consumer.dart';
import 'end_points.dart';

import 'package:mutazan_plus/core/errors/expentions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.options
      ..baseUrl = EndPoint.baseUrl
      ..connectTimeout = const Duration(seconds: 10) // بدّله بناءً على حاجتك
      ..receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future<dynamic> get( 
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final payload = isFormData ? FormData.fromMap(data) : data;
      final response = await dio.patch(
        path,
        data: payload,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final payload = isFormData ? FormData.fromMap(data) : data;
      final response = await dio.post(
        path,
        data: payload,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow; //إعادة رمي الاستثناء بعد معالجته
    }
  }
}
