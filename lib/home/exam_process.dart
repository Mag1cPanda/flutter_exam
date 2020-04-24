import 'package:flutter/material.dart';
import 'package:flutterexam/res/gaps.dart';
import 'package:flutterexam/routers/fluro_navigator.dart';
import 'package:flutterexam/routers/routes.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/common/global.dart';
import 'package:flutterexam/res/colors.dart';
import 'package:flutterexam/widgets/my_button.dart';

class ExamProcessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExamProcessPageState();
}

class _ExamProcessPageState extends State<ExamProcessPage> {
  String headerImg = 'assets/images/process_header_background.png';
  String step1Img = 'assets/images/process_step1.png';
  String step2Img = 'assets/images/process_step2.png';
  String step3Img = 'assets/images/process_step3.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _clickConfirm() {
    NavigatorUtils.push(context, Routes.examNotice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '考试流程',
      ),
      body:Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: _buildListView,
            ),
          ),
          MyButton(
            key: const Key('login'),
            onPressed: _clickConfirm,
            text: '确认',
          ),
        ],
      ),
    );
  }

  get _buildListView => [
    Padding(
      padding: EdgeInsets.all(20),
      child: Container(
          width: 700,
          height: 135,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: AssetImage(headerImg),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '投额与变额年金险资质模拟',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),

                Gaps.vGap10,

                Text(
                  '开始时间：2019-01-10  09：00',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
                  ),
                ),

                Gaps.vGap5,

                Text(
                  '结束时间：2019-01-10  09：00',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
                  ),
                ),

                Gaps.vGap5,

                Text(
                  '考试时长：120分钟',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          )
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
          Text('——   请认真阅读考试流程内容   ——', textAlign: TextAlign.center, style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),),
        ],
      ),
    ),

    Column(
      children: <Widget>[
        Gaps.vGap16,
        Row(
          children: <Widget>[
            Gaps.hGap10,
            Image(
              image: AssetImage(step1Img),
              width: 50,
              height: 50,
            ),
            Gaps.hGap10,
            Text(
              '第一步：考试入场',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),

        Row(
          children: <Widget>[
            Gaps.hGap70,
            Text(
              '请点击页面下方【确认】按钮也，进入第二步；',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        Gaps.vGap10,

        Row(
          children: <Widget>[
            Gaps.hGap10,
            Image(
              image: AssetImage(step2Img),
              width: 50,
              height: 50,
            ),
            Gaps.hGap10,
            Text(
              '第二步：阅读考试须知',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),

        Row(
          children: <Widget>[
            Gaps.hGap70,
            Text(
              '请仔细阅读考试须知，确保准时开始考试；',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        Gaps.vGap10,

        Row(
          children: <Widget>[
            Gaps.hGap10,
            Image(
              image: AssetImage(step3Img),
              width: 50,
              height: 50,
            ),
            Gaps.hGap10,
            Text(
              '第三步：开始考试',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),

        Row(
          children: <Widget>[
            Gaps.hGap70,
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  '进入考试后，请认真审题作答，严守考试纪律，考试中请勿离开。',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),



      ],
    ),


  ];
}