import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';

//return SpinKitFadingCircle(color: Colors.white);

class Loading {
  static bool isShow = false;
  static BuildContext _context;

  static showLoading(BuildContext context) {
    if (!isShow) {
      isShow = true;
      _context = context;
      showGeneralDialog(
          context: context,
          // barrierColor: Colors.white, // 背景色
          // barrierLabel: '',
          barrierDismissible: false, // 是否能通过点击空白处关闭
          transitionDuration: const Duration(milliseconds: 150), // 动画时长
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return Align(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Theme(
                  data: ThemeData(
                    cupertinoOverrideTheme: CupertinoThemeData(
                      brightness: Brightness.dark,
                    ),
                  ),
                  child: CupertinoActivityIndicator(
                    radius: 14,
                  ),
                ),
              ),
            );
          }).then((value) {
        isShow = false;
      });
    }
  }

  static hideLoading() {
    if (isShow) {
      Navigator.of(_context).pop();
    }
  }
}
