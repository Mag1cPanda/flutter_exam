import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterexam/res/gaps.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/common/global.dart';
import 'package:flutterexam/res/colors.dart';
import 'package:flutterexam/routers/fluro_navigator.dart';
import 'package:flutterexam/routers/routes.dart';
import 'package:flutterexam/net/dio_utils.dart';
import 'package:flutterexam/util/toast.dart';
import 'package:flutterexam/config/config.dart';
import 'dart:convert';
import 'package:flutterexam/widgets/my_button.dart';

class ExamQuestionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExamQuestionsPageState();
}

class _ExamQuestionsPageState extends State<ExamQuestionsPage> {
  String markImage = 'assets/images/question_mark.png';
  String unmarkImage = 'assets/images/question_unmark.png';
  PageController _pageController;
  int _currentIndex = 0;
  List _allQuestions = [];
  int _totalSeconds = 3600;
  Timer _timer;
  bool _timeState = true;
  String _displayTime = '00:00:00';
  String _hour = '00';
  String _minute = '00';
  String _second = '00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(
      initialPage: _currentIndex, //默认在第几个
      viewportFraction: 1, // 与父组件的比例
      keepPage: true, //是否保存当前 Page 的状态，如果保存，下次回复保存的那个 page，initialPage被忽略，
      //如果为 false 。下次总是从 initialPage 开始。
    );

    loadExamRecord();

    startTimer(_totalSeconds);
  }

  void startTimer(seconds) {
    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        //秒数减一，因为一秒回调一次
//        print(seconds);
        seconds--;
        _displayTime = constructTime(seconds);
      });
      if (seconds == 0) {
        //倒计时秒数为0，取消定时器
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  //时间格式化，根据总秒数转换为对应的 hh:mm:ss 格式
  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    _hour = formatTime(hour);
    _minute = formatTime(minute);
    _second = formatTime(second);
    return _hour + ":" + _minute + ":" + _second;
  }

  //数字格式化，将 0~9 的时间转换为 00~09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  void loadSingleQuestion(questionKey) {
    String cardNo = Global.instance.cardNumber;
    var params = {
      'cardno':cardNo,
      'key':questionKey,
    };
    DioUtils.loadData(
      getSingle,
      params: params,
      onSuccess: (data) {
        Map tmpData = jsonDecode(data);
        if(tmpData['resultstate'] == 1) {
          Map result = tmpData['result'];
          print(result);

          setState(() {

          });
        } else {
          Toast.show(data['resultdesc']);
        }
      },
      onError: (error) {
        print('请求出错' + getExamRecord);
      },
    );
  }

  void loadExamRecord() {
    String examid = Global.instance.selectedExam['examid'];
    var params = {
      'examid':examid
    };
    DioUtils.silentLoadData(
      getExamRecord,
      params: params,
      onSuccess: (data) {
//        print(getExamRecord + data);
        Map tmpData = jsonDecode(data);
//        print(tmpData['result']['1']);
        if(tmpData['resultstate'] == 1) {
          Map result = tmpData['result'];
          // 单选题1 ;多选题2 ; 判断题3 ; 填空题4 ;论述题8;
          if (result.containsKey('1')) {
            _allQuestions.addAll(tmpData['result']['1']);
          }
          if (result.containsKey('2')) {
            _allQuestions.addAll(tmpData['result']['2']);
          }
          if (result.containsKey('3')) {
            _allQuestions.addAll(tmpData['result']['3']);
          }
          if (result.containsKey('4')) {
            _allQuestions.addAll(tmpData['result']['4']);
          }
          if (result.containsKey('8')) {
            _allQuestions.addAll(tmpData['result']['8']);
          }

          for(int i=0; i<_allQuestions.length; i++) {
            Map tmp = _allQuestions[i];
            tmp['ismark'] = false;
          }
//          print('_allQuestions' + '${_allQuestions.length}');
          print(_allQuestions);

          setState(() {

          });

        } else {
          Toast.show(data['resultdesc']);
        }
      },
      onError: (error) {
        print('请求出错' + getExamRecord);
      },
    );
  }

  getQuestionType(index) {
    String typeid = _allQuestions[index]['_typeid'];
    // 单选题1 ;多选题2 ; 判断题3 ; 填空题4 ;论述题8;
    if (typeid == '1') {
      return '单选题';
    } else if (typeid == '2') {
      return '多选题';
    } else if (typeid == '3') {
      return '判断题';
    } else if (typeid == '4') {
      return '填空题';
    } else if (typeid == '8') {
      return '论述题';
    } else {
      return '';
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    cancelTimer();
    super.dispose();
  }

  Widget _rendPage(BuildContext context,int index, Map data){
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '${getQuestionType(index)}' + '(${data['_score']}分)',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        data['ismark'] = !data['ismark'];
                      });
                      print(data['ismark']);
                    },
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage(data['ismark']?markImage:unmarkImage),
                          width: 15,
                          height: 15,
                        ),
                        Gaps.hGap5,
                        Text('标记此题'),
                      ],
                    ),
                  ),
                ],
              ),

              Divider(color: Color(0xFFE5E5E5), height: 20,),

              Text(
                '${data['snumber']}.${data['_testdesc']}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Gaps.vGap16,

              Column(
                children: _buildOptions(data['_lstsubinfo']),
              ),
            ],
          ),
        ),
      ],
    );
  }


  List<Widget> _buildOptions(List data) {
    List<Widget> options = [];
    for(int i=0; i<data.length; i++) {
      Map item = data[i];
      options.add(
        GestureDetector(
          onTap: () {
            print(i);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x21FFA200),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0x21666666),
              ),
            ),
            padding: EdgeInsets.all(10),
//            height: 100,
            child: Row(
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
//                    color: Colors.red,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFFFA200),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item['subtitle'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                Gaps.hGap5,

                Expanded(
                  child: Text(
                    item['subdesc'],
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      );
      options.add(Gaps.vGap10);
    }
    return options;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: "${_currentIndex+1}/${_allQuestions.length}",
        actionName: '验证码登录',
        onPressed: () {
          print(_allQuestions);
//          loadExamRecord();
        },
      ),
      body:Column(
        children: <Widget>[
          Container(
            width: 750,
            height: 80,
//            color: Colors.green,
            child: Row(
              children: <Widget>[
                Gaps.hGap15,
                Container(
                  width: 34,
                  height: 25,
                  alignment: Alignment.center,
                  color: Color(0xFFE8E8E8),
                  child: Text("$_hour",style: TextStyle(color: Colors.black,fontSize: 16),),
                ),
                Text(' : ', style: TextStyle(color: Colors.black,fontSize: 16),),
                Container(
                  width: 34,
                  height: 25,
                  alignment: Alignment.center,
                  color: Color(0xFFE8E8E8),

                  child: Text("$_minute",style: TextStyle(color: Colors.black,fontSize: 16),),
                ),
                Text(' : ', style: TextStyle(color: Colors.black,fontSize: 16),),
                Container(
                  width: 34,
                  height: 25,
                  alignment: Alignment.center,
                  color: Color(0xFFE8E8E8),
                  child: Text("$_second",style: TextStyle(color: Colors.black,fontSize: 16),),
                ),
              ],
            ),
          ),

          Expanded(
            child: PageView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: _allQuestions.length,
              itemBuilder: (BuildContext context,int index)=>_rendPage(context, index, _allQuestions[index]),
              onPageChanged: (index) {
                print('index=====$index');
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),

          MyButton(
            key: const Key('login'),
            onPressed: null,
            text: '确认',
          ),

        ],
      ),
    );
  }
}