import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
//  static String login = "/login";
  static String chooseSubject = "/choose_subject";

  static void configureRoutes(Router router) {

    router.define(root, handler: loginHandler);
//    router.define(login, handler: loginHandler);
    router.define(chooseSubject,
        handler: chooseSubjectHandler, transitionType: TransitionType.native);
  }
}