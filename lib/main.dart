import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterexam/provider/theme_provider.dart';
import 'package:flutterexam/routers/application.dart';
import 'package:flutterexam/util/device_utils.dart';
import 'package:flutterexam/util/log_utils.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
//import 'package:flutterexam/home/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:flutterexam/login/page/login_page.dart';
import 'package:flutterexam/home/choose_subject_page.dart';

import 'package:flutterexam/routers/app_component.dart';
import 'package:flustars/flustars.dart' as FlutterStars;

void main() {
  runApp(MyApp());

  print('main');
  debugPrint('main');

  // 透明状态栏
  if (Device.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppComponent(),
    );
  }
}
