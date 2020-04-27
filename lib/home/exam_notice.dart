import 'package:flutter/material.dart';
import 'package:flutterexam/res/gaps.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/common/global.dart';
import 'package:flutterexam/res/colors.dart';
import 'package:flutterexam/widgets/my_button.dart';
import 'package:flutterexam/routers/fluro_navigator.dart';
import 'package:flutterexam/routers/routes.dart';
import 'package:flutterexam/net/dio_utils.dart';
import 'package:flutterexam/util/toast.dart';
import 'package:flutterexam/config/config.dart';
import 'dart:convert';

class ExamNoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExamNoticePageState();
}

class _ExamNoticePageState extends State<ExamNoticePage> {
  String headStr = '考生应遵循考试公平、公证原则，端正考试态度，严守考试相关纪律。若考生不遵守考试纪律，构成违纪、作弊行为达2次，将取消参加在线考试的资格，并判断本次考试成绩无效。';
  String bottemStr = '以上考试违纪行为若被系统抓拍到或巡考老师视频巡考看到，均以违反考试纪律处理。 请严格遵守考试纪律，认真独立完成考试！';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _clickConfirm() {
    String examid = Global.instance.selectedExam['examid'];
    var params = {
      'comfrom':'2',
      'examid':examid};
    print(params);
    DioUtils.loadData(
      createPaper,
      params: params,
      onSuccess: (data) {
        print('onSuccess');
        print(data);
        Map tmpData = jsonDecode(data);
        if(tmpData['resultstate'] == 1) {
          NavigatorUtils.push(context, Routes.examQuestions);
        } else {
          Toast.show(data['resultdesc']);
        }
      },
      onError: (error) {
        print('onError');
        Toast.show('请求出错');
      },
    );
  }

  get _buildList => [
    Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        headStr,
        style: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),

    Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        '以下情况均属于考试违纪行为',
        style: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    ),

    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        '1、利用各种照片代替本人通过人脸识别',
        style: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),

    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        '2、考试过程中使用手机、平板等电子产品',
        style: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),

    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        '3、考试过程中与他人交头接耳',
        style: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),

    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        '4、考试过程中轮换其他人代替考试',
        style: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),

    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        '5、考试中途离开视频监控画面',
        style: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),

    Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        bottemStr,
        style: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '考试须知',
      ),
      body:Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: _buildList,
            ),
          ),

          MyButton(
            key: const Key('login'),
            onPressed: _clickConfirm,
            text: '开始考试',
          ),
        ],
      ),
    );
  }
}