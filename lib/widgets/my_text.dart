import 'dart:async';
import 'package:flutter/material.dart';

class MyText extends StatefulWidget {


  const MyText({
    Key key,

  }): super(key: key);

  final String text = '';
  @override
  State createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  String _text = '';

  Widget build(BuildContext context) {
    return InkWell (
      child: Text (
        '$_text'
      ),
    );
  }
}