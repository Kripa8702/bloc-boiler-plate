import 'package:bloc_boiler_plate/exceptions/exceptions.dart';
import 'package:bloc_boiler_plate/services/app_flavor.dart';
import 'package:bloc_boiler_plate/utils/pref_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  Dio _dio = Dio();

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: AppFlavor.apiBaseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      validateStatus: (status) {
        return status! < 500;
      },
    ));

    _dio.options.headers = headers;
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: false,
      responseBody: true,
      responseHeader: false,
    ));
  }

  Map<String, String> get headers {
    final accessToken = PrefUtils().getString('token');
    final headers = {
      'Content-Type': 'application/json',
    };
    if (accessToken != null && accessToken != 'guest') {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);

      _print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw UnAuthorizedException(response.data['message'], statusCode: 401);
      } else if (response.statusCode == 400) {
        throw BadRequestException(response.data['message'], statusCode: 400);
      } else {
        throw OtherException(response.data['message'],
            statusCode: response.statusCode ?? 500);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
      );

      _print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw UnAuthorizedException(response.data['message'], statusCode: 401);
      } else if (response.statusCode == 400) {
        throw BadRequestException(response.data['message'], statusCode: 400);
      } else {
        throw OtherException(response.data['message'],
            statusCode: response.statusCode ?? 500);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);

      _print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw UnAuthorizedException(response.data['message'], statusCode: 401);
      } else if (response.statusCode == 400) {
        throw BadRequestException(response.data['message'], statusCode: 400);
      } else {
        throw OtherException(response.data['message'],
            statusCode: response.statusCode ?? 500);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);

      _print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw UnAuthorizedException(response.data['message'], statusCode: 401);
      } else if (response.statusCode == 400) {
        throw BadRequestException(response.data['message'], statusCode: 400);
      } else {
        throw OtherException(response.data['message'],
            statusCode: response.statusCode ?? 500);
      }
    } catch (e) {
      rethrow;
    }
  }

  _print(dynamic text) {
    if (kDebugMode) {
      print(text.toString());
    }
  }
}
