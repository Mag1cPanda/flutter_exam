import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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

void main() {
//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;

//  var codeArr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
//    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
//  String result = '';
//  for (int i = 0; i < 4; i++) {
//    result = result + codeArr[Random().nextInt(codeArr.length)];
//  }



  runApp(MyApp());

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
