import 'package:flutter/painting.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutterexam/login/page/login_page.dart';
import 'package:flutterexam/home/choose_subject_page.dart';

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LoginPage();
    });

var chooseSubjectHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ChooseSubjectPage();
    });