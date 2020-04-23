import 'package:flutter/material.dart';
import 'package:flutterexam/res/gaps.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/common/global.dart';
import 'package:flutterexam/res/colors.dart';

class ExamNoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExamNoticePageState();
}

class _ExamNoticePageState extends State<ExamNoticePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '考试须知',
        actionName: '验证码登录',
        onPressed: () {

        },
      ),
      body:Text('1111'),
    );
  }
}