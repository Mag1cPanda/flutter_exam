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
import 'package:azlistview/azlistview.dart';
import 'dart:convert';
import 'package:flutterexam/widgets/grouped_listview.dart';
import 'contact_model.dart';
import 'exam_model.dart';
import 'package:lpinyin/lpinyin.dart';

class ChooseSubjectPage extends StatefulWidget {
  @override
  _ChooseSubjectPageState createState() => _ChooseSubjectPageState();
}

class _ChooseSubjectPageState extends State<ChooseSubjectPage> {
  List<ContactInfo> _contacts = List();
  List _exams = Global.instance.exam;
  int _suspensionHeight = 40;
  int _itemHeight = 100;
  String _suspensionTag = "";

  String selectedIcon = 'assets/images/ic_back_black.png';
  String unselectedIcon = 'assets/images/ic_back_black.png';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {

    rootBundle.loadString('assets/data/contacts.json').then((value) {
      List list = json.decode(value);
      list.forEach((value) {
        _contacts.add(ContactInfo(name: value['name']));
      });
      _handleList(_contacts);



//      for(int i=0; i<Global.instance.exam.length; i++) {
//        List list = Global.instance.exam[i]['list'];
//        for(int j=0; j<list.length; j++) {
//          Global.instance.exam[i]['list'][j]['selected'] = false;
//          Global.instance.exam[0]['list'][0]['exampic'] = '111111';
//        }
//      }

      setState(() {});
    });


  }

  void _handleList(List<ContactInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_contacts);
  }

  Widget _buildSusWidget(String susTag) {
    return Container (
      padding: EdgeInsets.all(20.0),
      width: 750,
//      height: _suspensionHeight.toDouble(),
      child: Row(children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFF96065), width: 0.5),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            child: Text('考试类型',
              style: TextStyle(
                color: const Color(0xFFF96065),
                fontSize: 10,
              ),
            ),
          )
        ),

        Gaps.hGap10,
        Text('永兴元企业员工测评',
          style: TextStyle(
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],),
    );
  }

  Widget _buildListItem(ContactInfo model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
//          height: _itemHeight.toDouble(),
          child: ListTile(
            leading: Image.asset(
                'assets/images/ic_back_black.png'
            ),
            title: Text(model.name),
            onTap: () {
              print("OnItemClick: $model");
            },
          ),
        )
      ],
    );
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
          print(_exams);
//          print(Global.instance.exam);
        },
      ),
      body:MyScrollView(
//        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
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

    AzListView(
      data: _contacts,
      itemBuilder: (context, model) => _buildListItem(model),
      indexBarBuilder: (BuildContext context, List<String> tags,
          IndexBarTouchCallback onTouch) {
        return null;
      },
//      isUseRealIndex: true,
      itemHeight: _itemHeight,
      suspensionHeight: _suspensionHeight,
    ),

//    MyButton(
//      key: const Key('login'),
//      onPressed: _clickable ? _login : null,
//      text: '确认',
//    ),
  ];
}