import 'package:flutter/material.dart';
import 'package:flutterexam/res/gaps.dart';
import 'package:flutterexam/routers/application.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/common/global.dart';
import 'package:flutterexam/res/colors.dart';
import 'package:flutterexam/widgets/my_button.dart';
import 'package:flutterexam/routers/routes.dart';
import 'package:flutterexam/routers/fluro_navigator.dart';
import 'package:flutterexam/util/toast.dart';
import 'package:flutterexam/net/dio_utils.dart';
import 'package:flutterexam/config/config.dart';

import 'dart:convert';

class SelectPaperPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectPaperPageState();
}

class _SelectPaperPageState extends State<SelectPaperPage> {
  List _paperList = [
    {
      "beanname": "examoldatconfig",
      "showname": "moduelinfo100_999",
      "creator": "super",
      "createtime": "2020-04-01 10:36:19.065",
      "configid": "8d27ca8872404d24998714ce1280376f",
      "datname": "思想道德修养与法律基础试卷A",
      "id": "26c212603bb24615b365b5ab0d925d27",
      "updatetime": "2020-04-01 11:27:54.686",
      "updater": "super"
    },
    {
      "beanname": "examoldatconfig",
      "showname": "moduelinfo100_999_1",
      "creator": "super",
      "createtime": "2020-04-01 10:47:49.027",
      "configid": "8d27ca8872404d24998714ce1280376f",
      "datname": "思想道德修养与法律基础试卷B",
      "id": "e1bcea67239143b1b0e7d812d55179d3",
      "updatetime": "2020-04-01 11:28:11.673",
      "updater": "super"
    },
    {
      "beanname": "examoldatconfig",
      "showname": "moduelinfo100_999_2",
      "creator": "super",
      "createtime": "2020-04-01 11:01:16.753",
      "configid": "8d27ca8872404d24998714ce1280376f",
      "datname": "思想道德修养与法律基础试卷C",
      "id": "a890fac72dfd44aaa9e7dfaef16481fa",
      "updatetime": "2020-04-01 11:28:19.286",
      "updater": "super"
    }
  ];

  Map _selectedPaper = {};
  bool _clickable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String examType = Global.instance.selectedType;
    String examSubject = Global.instance.selectedExam['examsubject'];
    var params = {
      'examtype': examType,
      'examsubject': examSubject,
    };
    var bean = {'bean': params};
    print(bean);
//    DioUtils.loadData(
//      searchDatFile,
//      params: bean,
//      onSuccess: (data) {x
//        Map tmp = jsonDecode(data);
//        print(tmp);
//      },
//      onError: (error) {
//        Toast.show('请求失败');
//      },
//    );
  }

  void loadData() async {}

  void _checkQuestions() {
    Global.instance.selectedPaper = _selectedPaper;
    print(Global.instance.selectedPaper);
    NavigatorUtils.push(context, Routes.paperDetail);
  }

  void _toExamProcess() {
    NavigatorUtils.push(context, Routes.examProcess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '选择试卷',
//        isBack: false,
        actionName: '验证码登录',
        onPressed: () {
          print(Global.instance.selectedType);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              '请在以下试卷中选择一套进行作答，注意只能选择一套试卷作答',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Column(
                children:
                    _paperList.map((paper) => _buildPaper(paper)).toList()),
          ),
//          MyButton(
//            key: const Key('login'),
//            onPressed: _clickable ? _clickConfirm : null,
//            text: '确认',
//          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            //交叉轴的布局方式，对于column来说就是水平方向的布局方式
//            crossAxisAlignment: CrossAxisAlignment.center,
            //就是字child的垂直布局方向，向上还是向下
//            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              FlatButton(
                onPressed: _clickable ? _checkQuestions : null,
                color: Colours.app_main,
                disabledColor: Colours.button_disabled,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    '查看题目',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Gaps.hGap50,
              FlatButton(
                onPressed: _clickable ? _toExamProcess : null,
                color: Colours.app_main,
                disabledColor: Colours.button_disabled,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    '开始考试',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          Gaps.vGap50,
        ],
      ),
    );
  }

  Widget _buildPaper(paper) {
    return GestureDetector(
      onTap: () {
        //反选 重置_selectedExam
        if (_selectedPaper != {}) {
          setState(() {
            _selectedPaper = {};
            _clickable = false;
          });
        }
      },
      child: RadioListTile(
        activeColor: Colours.app_main,
        value: paper,
        title: Text(
          paper['datname'],
          style: TextStyle(
            color:
                _selectedPaper == paper ? Color(0xFFFFA200) : Color(0xFF333333),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        groupValue: _selectedPaper,
        onChanged: (value) {
          setState(() {
            _selectedPaper = paper;
            _clickable = true;
          });
        },
      ),
    );
  }
}
