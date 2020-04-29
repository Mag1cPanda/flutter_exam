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
import 'exam_model.dart';
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
  List _exams = Global.instance.exam;
  bool _clickable = false;

  Map _selectedExam = {};

  String _isexamcode = '';//是否需要考试码
  String _randomcode = '';//考试码
  String _dats = '';
  String _choosestate = '';
  String _viewsatte = '';
  String _examstate = '';

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
      var examType = exam['examtype'];
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
    Global.instance.selectedExam = _selectedExam;

    String examId = _selectedExam['examid'];
    String examSubject = _selectedExam['examsubject'];
    String examType = '';

    //获取上层examType
    for(int i=0; i<_exams.length; i++) {
      var exam = _exams[i];
      var subjects = exam['list'];
      for(int j=0; j<subjects.length; j++) {
        var obj = subjects[j];
        if(obj['examid'] == examId) {
          examType = Global.instance.selectedType = exam['examtype'];
        }
      }
    }

    var params = {
      'examtype':examType,
      'examsubject':examSubject,
      'examid':examId,
    };
    var bean = {'bean':params};
    DioUtils.loadData(
      getExamProcess,
      params: bean,
      onSuccess: (data) {
        Map tmp = jsonDecode(data);
        Map result = tmp['result'];
        Map listData = result['list'];

        _isexamcode = listData['isexamcode'];
        _randomcode = listData['randomcode'];
        _dats = listData['dats'].toString();
        _choosestate = listData['choosestate'];
        _viewsatte = listData['viewsatte'];
        _examstate = listData['examstate'];

        NavigatorUtils.push(context, Routes.examProcess);
      },
      onError: (error) {
        Toast.show('请求失败');
      },
    );
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
          setState(() {
            _selectedExam = subject;
            _clickable = true;
          });
        },
      ),
    );
  }
}