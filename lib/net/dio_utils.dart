import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutterexam/config/config.dart';

class DioUtils {
  static Dio _dio;

  static Dio buildDio() {
    if (_dio == null) {
       BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {"App-Version":"78","Content-Type":"application/json",},
        responseType: ResponseType.plain,
        baseUrl: debugBaseUrl,
      );
      _dio = new Dio(options);
    }
    return _dio;
  }

//  DioUtils._internal() {
//    var options = BaseOptions(
//      method: 'post',
//    );
//    _dio = Dio(options);
//  }

  static void loadData<T>(
      String methodName, {
        params,
        Function(T t) onSuccess,
        Function(String error) onError,
      }) async {
//    var url = bxContext + getExamSubject + suffix;
//    Response response = await _dio.post(url,
//        data: {'cardno': '42100419920521421X'});
    var url = bxContext + methodName + suffix;
    var result;
    try {
      Response response = await DioUtils.buildDio().post(url,
          data: params);
      result = response.data;
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          onSuccess(result);
        }
//        print('响应数据：' + response.toString());
      } else {
        throw Exception('statusCode:${response.statusCode}');
      }
    } catch (e) {
      print('请求出错：' + e.toString());
      onError(e.toString());
    }
  }
}