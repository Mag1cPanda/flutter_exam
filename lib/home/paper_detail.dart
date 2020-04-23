import 'package:flutter/material.dart';
import 'package:flutterexam/config/config.dart';
import 'package:flutterexam/res/gaps.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/common/global.dart';
import 'package:flutterexam/res/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class PaperDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaperDetailPageState();
}

class _PaperDetailPageState extends State<PaperDetailPage> {

  String _paperUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String datid = '';
    String datname = '';
    String examid = '';
    String path = 'LEAP/EXAMOLH5/html/examviewpaper.html?id=';
    _paperUrl = baseUrl + path + datid + "&datname=" + datname + "&examid=" + examid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '试卷详情',
        actionName: '验证码登录',
        onPressed: () {

        },
      ),
      body:WebView(
        navigationDelegate: (NavigationRequest request) {
          var url = request.url;
          print("visit $url");
          setState(() {
//              isLoading = true; // 开始访问页面，更新状态
          });

          return NavigationDecision.navigate;
        },
        onPageFinished: (String url) {
          print(url);
        },
//          initialUrl:Uri.encodeFull('https://www.baidu.com'),
        initialUrl:'https://www.baidu.com',
        javascriptMode: JavascriptMode.unrestricted,

      ),
    );
  }
}