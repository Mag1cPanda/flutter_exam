import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:flutterexam/common/common.dart';
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

import '../login_router.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //定义一个controller
  TextEditingController _cardNumberCTR = TextEditingController();
  TextEditingController _authCodeCTR = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
//  bool _clickable = false;

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _cardNumberCTR.addListener(_verify);
    _authCodeCTR.addListener(_verify);
    _cardNumberCTR.text = FlutterStars.SpUtil.getString(Constant.cardNumber);
  }

  void _verify() {
    String cardNumber = _cardNumberCTR.text;
    String authCode = _authCodeCTR.text;
    bool clickable = true;
    //后面改为正则表达式
//    if (cardNumber.isEmpty || cardNumber.length < 15) {
//      clickable = false;
//    }
//    if (authCode.isEmpty || authCode.length < 4) {
//      clickable = false;
//    }

    /// 状态不一样在刷新，避免重复不必要的setState
//    if (clickable != _clickable) {
//      setState(() {
//        _clickable = clickable;
//      });
//    }
  }

  void _login() {
//    FlutterStars.SpUtil.putString(Constant.cardNumber, _cardNumberCTR.text);
    Navigator.pushNamed(context, 'choose_subject');
    Application.router.navigateTo(
        context, "choose_subject");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '在线考试',
//        isBack: false,
        actionName: '验证码登录',
        onPressed: () {
//          print('111111');
          Navigator.pushNamed(context, 'choose_subject');
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
    ),
    Gaps.vGap8,
    MyTextField(
      key: const Key('authCode'),
      keyName: 'authCode',
      focusNode: _nodeText2,
      isInputPwd: true,
      controller: _authCodeCTR,
      keyboardType: TextInputType.visiblePassword,
      maxLength: 16,
      hintText: '请输入验证码',
    ),
    Gaps.vGap24,
    MyButton(
      key: const Key('login'),
      onPressed: _login,
//      onPressed: _clickable ? _login : null,
      text: '确认',
    ),
  ];
}