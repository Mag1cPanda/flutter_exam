import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route_handlers.dart';
import 'package:flutterexam/home/webview_page.dart';

class Routes {
  static String root = "/";
  static String chooseSubject = "/choose_subject";
  static String selectPaper = "/select_paper";
  static String paperDetail = "/paper_detail";
  static String examProcess = "/exam_process";
  static String examNotice = "/exam_notice";
  static String examQuestions = "/exam_questions";
  static String webViewPage = '/webview';

  static void configureRoutes(Router router) {

    router.define(root, handler: loginHandler);
    router.define(chooseSubject, handler: chooseSubjectHandler, transitionType: TransitionType.inFromRight);
    router.define(selectPaper, handler: selectPaperHandle, transitionType: TransitionType.inFromRight);
    router.define(paperDetail, handler: paperDetailHandle, transitionType: TransitionType.inFromRight);
    router.define(examProcess, handler: examProcessHandle, transitionType: TransitionType.inFromRight);
    router.define(examNotice, handler: examNoticeHandle, transitionType: TransitionType.inFromRight);
    router.define(examQuestions, handler: examQuestionsHandle, transitionType: TransitionType.inFromRight);

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));
  }
}