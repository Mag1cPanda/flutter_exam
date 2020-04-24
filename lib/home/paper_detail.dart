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
    String datid = Global.instance.selectedPaper['id'];
    String datname = Global.instance.selectedPaper['datname'];
    String examid = Global.instance.selectedExam['examid'];

    String path = '/LEAP/EXAMOLH5/html/examviewpaper.html?id=';

    String fullUrl = baseUrl + bxContext + path + datid + "&datname=" + datname + "&examid=" + examid;
    setState(() {
      _paperUrl = Uri.encodeFull(fullUrl);
    });

//    print(_paperUrl);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '试卷详情',
        actionName: '验证码登录',
        onPressed: () {
          print(Global.instance.selectedPaper);
//          print(_paperUrl);
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
        initialUrl:_paperUrl,
        javascriptMode: JavascriptMode.unrestricted,

      ),
    );
  }
}