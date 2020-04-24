
import 'package:dio/dio.dart';
import 'package:flutterexam/config/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    var url = bxContext + restAPI + methodName + suffix;
    EasyLoading.show();
    var result;
    try {
      Response response = await DioUtils.buildDio().post(url,
          data: params);
      result = response.data;
      EasyLoading.dismiss();
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
      EasyLoading.dismiss();
    }
  }
}