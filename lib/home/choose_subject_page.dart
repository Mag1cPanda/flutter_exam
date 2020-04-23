import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterexam/common/common.dart';
import 'package:flutterexam/res/resources.dart';
import 'package:flutterexam/routers/fluro_navigator.dart';
import 'package:flutterexam/util/utils.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/widgets/my_scroll_view.dart';
import 'package:flutterexam/common/global.dart';
import 'package:flutterexam/util/toast.dart';
import 'dart:convert';
import 'package:flutterexam/widgets/grouped_listview.dart';
import 'contact_model.dart';
import 'exam_model.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:flutterexam/widgets/my_button.dart';
import 'package:flutterexam/routers/application.dart';
import 'package:flutterexam/net/dio_utils.dart';
import 'package:flutterexam/common/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterexam/config/config.dart';
import 'package:flutterexam/routers/routes.dart';

class ChooseSubjectPage extends StatefulWidget {
  @override
  _ChooseSubjectPageState createState() => _ChooseSubjectPageState();
}

class _ChooseSubjectPageState extends State<ChooseSubjectPage> {
//  List _exams = [
//    {'javaClass': 'com.longrise.LEAP.Base.Objects.EntityBean',
//      'examtype': '100',
//      'examtypename': '永兴元企业员工测评',
//      'list':[{'examsubject': '999',
//        'examtypename': 'sp测试科目',
//        'examid': '49348573d1d340bb98dafa0702c5ecb9',
//        'exampic': 'http://wuhan.yxybb.com/BXEXAMOL/LEAP/Download/default/2020/4/9//0f7ef1d5caac45229b374ce265bdb9c7.jpg',
//        'selected': false}],
//    },
//  ];
  List _exams = Global.instance.exam;
  bool _clickable = false;

//  String selectedIcon = 'assets/images/ic_back_black.png';
//  String unselectedIcon = 'assets/images/ic_back_black.png';
  Map _selectedExam = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    for(int i=0; i<_exams.length; i++) {
      List list = _exams[i]['list'];
      for(int j=0; j<list.length; j++) {
        _exams[i]['list'][j]['selected'] = false;
      }
    }

    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '选择科目',
//        isBack: false,
        actionName: '验证码登录',
        onPressed: () {
//          print(Global.instance.exam[0]['list'][0]['selected']);
//          print(_exams);
          print(Global.instance.exam);
        },
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBody,
      ),
    );
  }

  get _buildBody => [
    Container (
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('考生姓名：${Global.instance.personName}', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
          Gaps.vGap16,
          Text('证件号码：${Global.instance.cardNumber}', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
        ],
      ),
    ),

    Container(
        width: 750.0,
        height: 10.0,
        color: Color(0xFFF3F3F3),
    ),

    Gaps.vGap16,

    Container (
      width: 750,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('——  请选择考试科目  ——', textAlign: TextAlign.center,),
        ],
      ),
    ),

    //List撑满剩余控件，使按钮固定到底部
    Expanded(
      child: ListView(
        children: _buildList(),
      ),
    ),

    MyButton(
      key: const Key('login'),
      onPressed: _clickable ? _clickConfirm : null,
      text: '确认',
    ),
  ];

  List<Widget> _buildList() {
    List<Widget> widgets = [];

    for(int i=0; i<_exams.length; i++) {
      var exam = _exams[i];
      var typeName = exam['examtypename'];
      var subjects = exam['list'];
      widgets.add(_item(typeName, subjects));
    }

    return widgets;
  }


  Widget _item(String typeName, List subjects) {
    return Column(
      children: <Widget>[
        Gaps.vGap16,
        Row(
          children: <Widget>[
            Gaps.hGap20,
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),///圆角
                  border: Border.all(color: Color(0xFFF96065),width: 1)///边框颜色、宽
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Text(
                  '考试类型',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFF96065),
                  ),
                ),
              ),
            ),
            Gaps.hGap10,
            Text(typeName,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Column(
            children: subjects.map((subject) => _buildSub(subject)).toList()),
      ],
    );
  }

  void _clickConfirm() {
    print(_selectedExam);


//    EasyLoading.show();
//    var params = {'cardno':Global.instance.cardNumber};
//    DioUtils.loadData(
//      getExamProcess,
//      params: params,
//      onSuccess: (data) {
//        print('onSuccess');
////        Map examData = jsonDecode(data);
//        EasyLoading.dismiss();
//
//        Application.router.navigateTo(context, Routes.selectPaper);
//      },
//      onError: (error) {
//        print('onError');
//        EasyLoading.dismiss();
//        Toast.show('登录失败');
//      },
//    );


  }

  Widget _buildSub(Map subject) {
    return GestureDetector(
      onTap: (){
        //反选 重置_selectedExam
        if(_selectedExam != {}) {
          setState(() {
            _selectedExam = {};
            _clickable = false;
          });
        }
      },
      child: RadioListTile(
        activeColor: Colours.app_main,
        value: subject,
        title: Text(
          subject['examtypename'],
          style: TextStyle(
            color: _selectedExam==subject ? Color(0xFFFFA200) : Color(0xFF333333),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        groupValue: _selectedExam,
        onChanged: (value) {
          print(value);
          setState(() {
            _selectedExam = subject;
            _clickable = true;
          });
        },
      ),
    );
  }
}