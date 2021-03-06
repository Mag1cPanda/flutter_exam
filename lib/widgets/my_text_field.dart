
import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterexam/res/resources.dart';
import 'package:flutterexam/util/utils.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:flutterexam/common/common.dart';
import 'package:flutterexam/common/global.dart';

import 'load_image.dart';


/// 登录模块的输入框封装
class MyTextField extends StatefulWidget {

  const MyTextField({
    Key key,
    @required this.controller,
    this.maxLength: 16,
    this.autoFocus: false,
    this.keyboardType: TextInputType.text,
    this.hintText: '',
    this.focusNode,
    this.isInputPwd: false,
    this.getVCode,
    this.keyName,
    this.randomCode,

    this.prefixIconPath: '',
    this.imageURL: '',
  }): super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool isInputPwd;
  final Future<bool> Function() getVCode;
  final String imageURL;
  final String prefixIconPath;
  final String randomCode;
  /// 用于集成测试寻找widget
  final String keyName;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;
  String _randomCode = '';

  /// 倒计时秒数
  final int _second = 30;
  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isEmpty;
    /// 监听输入改变
    widget.controller.addListener(isEmpty);

    _randomCode = widget.randomCode;

  }

  void isEmpty() {
    bool isEmpty = widget.controller.text.isEmpty;
    /// 状态不一样在刷新，避免重复不必要的setState
    if (isEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isEmpty;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
    widget.controller?.removeListener(isEmpty);
  }

  _getVCode () {
    var result = Utils.getRandomCode(4);

    Global.instance.randomCode = result;

    //告诉Flutter框架State改变
    setState(() {
      _randomCode = result;
    });
  }

//  void _putRandomCode() async {
//    await FlutterStars.SpUtil.getInstance();
//    FlutterStars.SpUtil.putString(Constant.randomCode, _randomCode);
//    print('putString:' + _randomCode);
//  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDark = themeData.brightness == Brightness.dark;
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextField(
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          obscureText: widget.isInputPwd ? !_isShowPwd : false,
          autofocus: widget.autoFocus,
          controller: widget.controller,
          textInputAction: TextInputAction.done,
          keyboardType: widget.keyboardType,

          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              hintText: widget.hintText,
              counterText: '',
              prefixIcon: Container(
                padding: EdgeInsets.all(8.0),
                width: 40,
                height: 40,
                child: Image.asset(
                  widget.prefixIconPath,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colours.app_main,
                      width: 0.8
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colours.unselected_item_color,
                      width: 0.8
                  )
              )
          ),
        ),

        Container(
          height: widget.randomCode != null ? 40 : 0,
          margin:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//          color: Colors.red,
          child: FlatButton(
            onPressed: _getVCode,
            textColor: Colors.white,
            color: Colours.app_main,
            disabledTextColor: isDark ? Colours.dark_text : Colors.white,
            disabledColor: isDark ? Colours.dark_text_gray : Colours.text_gray_c,
            child: Text(
              '$_randomCode',
              style: TextStyle(fontSize: Dimens.font_sp16),
            ),
          ),
        ),

      ],
    );
  }
}
