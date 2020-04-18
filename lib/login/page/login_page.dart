import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:flutterexam/common/common.dart';
import 'package:flutterexam/config/config.dart';
import 'package:flutterexam/res/resources.dart';
import 'package:flutterexam/routers/fluro_navigator.dart';
import 'package:flutterexam/util/log_utils.dart';
import 'package:flutterexam/util/toast.dart';
import 'package:flutterexam/util/utils.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/widgets/my_button.dart';
import 'package:flutterexam/widgets/my_scroll_view.dart';
import 'package:flutterexam/widgets/my_text_field.dart';
import 'package:flutterexam/routers/application.dart';
import 'package:flutterexam/widgets/my_loading.dart';

import 'package:flutterexam/routers/routes.dart';
import 'dart:math';
import 'dart:convert';

import 'package:flutterexam/net/dio_utils.dart';


class LoginPage extends StatefulWidget {
  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _cardNumberCTR = TextEditingController();
  TextEditingController _authCodeCTR = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;
  String _randomCode = '';

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _cardNumberCTR.addListener(_verify);
    _authCodeCTR.addListener(_verify);
    FlutterStars.SpUtil.getInstance();
    _cardNumberCTR.text = FlutterStars.SpUtil.getString(Constant.cardNumber);

    //获取随机字符串
    _randomCode = Utils.getRandomCode(4);
    _putRandomCode();
  }

  void _getRandomCode() async {
    await FlutterStars.SpUtil.getInstance();
    _randomCode = FlutterStars.SpUtil.getString(Constant.randomCode);
    print('getString:' + _randomCode);
  }

  void _putRandomCode() async {
    await FlutterStars.SpUtil.getInstance();
    FlutterStars.SpUtil.putString(Constant.randomCode, _randomCode);
    print('putString:' + _randomCode);
  }

  void _verify() {
    String cardNumber = _cardNumberCTR.text;
    String authCode = _authCodeCTR.text;
    bool clickable = true;
    //后面改为正则表达式
    if (cardNumber.isEmpty || cardNumber.length < 15) {
      clickable = false;
    }

    _getRandomCode();
    if (authCode.isEmpty || authCode.toUpperCase() != _randomCode) {
      clickable = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _login() {


    if (FocusScope.of(context).isFirstFocus) {
      FocusScope.of(context).unfocus();
    }

    var params = {'cardno':_cardNumberCTR.text};

    DioUtils.loadData(
      getExamSubject,
      params: params,
      onSuccess: (data) {
        print('onSuccess');
        Map<String, dynamic> examData = jsonDecode(data);
        String tmp = examData['result']['javaClass'];
        print(tmp);
      },
      onError: (error) {
        print('onError');
      },
    );

//    Application.router.navigateTo(context, "choose_subject");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '在线考试',
        isBack: false,
        actionName: '验证码登录',
        onPressed: () {
          String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
          String result = '';
          print(alphabet);
          for (int i = 0; i < 4; i++) {
            result = result + alphabet[Random().nextInt(alphabet.length)];
          }
          result = result.toUpperCase();
          print(result);
        },
      ),
      body:MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2]),
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody,
      ),

    );
  }

  get _buildBody => [
    Gaps.vGap16,
    MyTextField(
      key: const Key('cardNumber'),
      focusNode: _nodeText1,
      controller: _cardNumberCTR,
      maxLength: 18,
      keyboardType: TextInputType.text,
      hintText: '请输入身份证号号',
      prefixIconPath: 'assets/images/login_cardno.png',
    ),
    Gaps.vGap8,
    MyTextField(
      key: const Key('authCode'),
      keyName: 'authCode',
      focusNode: _nodeText2,
      controller: _authCodeCTR,
      keyboardType: TextInputType.text,
      maxLength: 4,
      hintText: '请输入验证码',
      prefixIconPath: 'assets/images/auth_code.png',
      randomCode: _randomCode,
    ),
    Gaps.vGap24,
    MyButton(
      key: const Key('login'),
      onPressed: _clickable ? _login : null,
      text: '确认',
    ),
  ];
}