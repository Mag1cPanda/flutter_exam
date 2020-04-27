import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterexam/res/gaps.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/common/global.dart';
import 'package:flutterexam/res/colors.dart';
import 'package:flutterexam/routers/fluro_navigator.dart';
import 'package:flutterexam/routers/routes.dart';
import 'package:flutterexam/net/dio_utils.dart';
import 'package:flutterexam/util/toast.dart';
import 'package:flutterexam/config/config.dart';
import 'dart:convert';

class ExamQuestionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExamQuestionsPageState();
}

class _ExamQuestionsPageState extends State<ExamQuestionsPage> {
  PageController _pageController;
  int _index = 0;
  List _allQuestions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(
      initialPage: _index, //默认在第几个
      viewportFraction: 1, // 占屏幕多少，1为占满整个屏幕
      keepPage: true, //是否保存当前 Page 的状态，如果保存，下次回复保存的那个 page，initialPage被忽略，
      //如果为 false 。下次总是从 initialPage 开始。
    );
  }

  void loadExamRecord() async {
    String examid = Global.instance.selectedExam['examid'];
    var params = {
      'examid':examid
    };
    print(params);
    DioUtils.loadData(
      getExamRecord,
      params: params,
      onSuccess: (data) {
        print('onSuccess');
//        print(getExamRecord + data);
        Map tmpData = jsonDecode(data);
        print(tmpData['result']['1']);
        if(tmpData['resultstate'] == 1) {

        } else {
          Toast.show(data['resultdesc']);
        }
      },
      onError: (error) {
        print('onError');
        Toast.show('请求出错');
      },
    );

    setState(() {

    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: "${_index+1}/5",
        actionName: '验证码登录',
        onPressed: () {
          loadExamRecord();
        },
      ),
      body:PageView(
        scrollDirection: Axis.horizontal,
        reverse: false,
        controller: _pageController,
        physics:BouncingScrollPhysics(),
        pageSnapping: true,
        onPageChanged: (index) {
          print('index=====$index');
          setState(() {
            _index = index;
          });
        },
        children: <Widget>[
          Container(
            color: Colors.tealAccent,
            child: Center(
              child: Text(
                '第1页',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),

          Container(
            color: Colors.tealAccent,
            child: Center(
              child: Text(
                '第2页',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),

          Container(
            color: Colors.tealAccent,
            child: Center(
              child: Text(
                '第3页',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}