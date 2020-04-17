import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutterexam/config/config.dart';

class DioUtils {
  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal() {

    var headers = Map<String, String>();
    headers["App-Version"] = "78";
    headers['Content-Type'] = 'application/json';

    var options = BaseOptions(
      method: 'post',
      headers: headers,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.plain,
      baseUrl: debugBaseUrl,
//      contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
    );
    _dio = Dio(options);
    /// Fiddler抓包代理配置 https://www.jianshu.com/p/d831b1f7c45b
//    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (HttpClient client) {
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return 'PROXY 10.41.0.132:8888';
//      };
//      client.badCertificateCallback =
//          (X509Certificate cert, String host, int port) => true;
//    };
    /// 统一添加身份验证请求头
//    _dio.interceptors.add(AuthInterceptor());
    /// 刷新Token
//    _dio.interceptors.add(TokenInterceptor());
    /// 打印Log(生产模式去除)
//    if (!Constant.inProduction) {
//      _dio.interceptors.add(LoggingInterceptor());
//    }
    /// 适配数据(根据自己的数据结构，可自行选择添加)
//    _dio.interceptors.add(AdapterInterceptor());
  }

  void loadData(methodName, params) async {
//    var url = bxContext + getExamSubject + suffix;
//    Response response = await _dio.post(url,
//        data: {'cardno': '42100419920521421X'});

    var url = bxContext + methodName + suffix;
    Response response = await _dio.post(url,
        data: params);

    if (response.statusCode == HttpStatus.ok) {
      debugPrint(
          '-------------------请求成功,请求结果如下:-----------------\n'
              '===请求url: ${response.request.uri.toString()} \n'
              '===请求结果: \n${response.data}\n');
      debugPrint('-------------------请求成功,请求结果打印完毕----------------');


    } else {
      print('请求失败');
    }
  }
}