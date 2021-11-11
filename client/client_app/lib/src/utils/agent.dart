import 'package:client_app/src/utils/http_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Agent {
  final String url;
  final Map data;

  Agent({
    @required this.url,
    this.data,
  });

  Future<Dio> _dio() async {
    // Token Interceptor
    final prefs = await SharedPreferences.getInstance();
    var token = '';
    if (prefs.containsKey('userData')) {
      final extracted =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      token = extracted['token'];
    }

    return Dio(BaseOptions(headers: {
      'Authorization': '$token',
    }));
  }

  Future<dynamic> get() async {
    try {
      final agent = await _dio();
      Response response = await agent.get(this.url);
      return response.data;
    } on DioError catch (e) {
      throw HttpException(e.response.data, e.response.statusCode);
    }
  }

  Future<dynamic> post(Map body) async {
    try {
      final agent = await _dio();
      Response response = await agent.post(this.url, data: body);
      return response.data;
    } on DioError catch (e) {
      throw HttpException(e.response.data, e.response.statusCode);
    }
  }

  Future<dynamic> put(Map body) async {
    try {
      final agent = await _dio();
      Response response = await agent.put(this.url, data: body);
      return response.data;
    } on DioError catch (e) {
      throw HttpException(e.response.data, e.response.statusCode);
    }
  }

  // delete
  Future<dynamic> delete() async {
    try {
      final agent = await _dio();
      Response response = await agent.delete(this.url);
      return response.data;
    } on DioError catch (e) {
      throw HttpException(e.response.data, e.response.statusCode);
    }
  }

  // post multipart/form
}
