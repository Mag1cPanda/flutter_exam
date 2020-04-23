import 'package:flutter/painting.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutterexam/login/page/login_page.dart';
import 'package:flutterexam/home/choose_subject_page.dart';
import 'package:flutterexam/home/select_paper.dart';
import 'package:flutterexam/home/paper_detail.dart';
import 'package:flutterexam/home/exam_process.dart';
import 'package:flutterexam/home/exam_notice.dart';
import 'package:flutterexam/home/exam_questions.dart';

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LoginPage();
    });

var chooseSubjectHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ChooseSubjectPage();
    });

var selectPaperHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SelectPaperPage();
    });

var paperDetailHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return PaperDetailPage();
    });

var examProcessHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ExamProcessPage();
    });

var examNoticeHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ExamNoticePage();
    });

var examQuestionsHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return ExamQuestionsPage();
    });