import 'package:flutter/material.dart';
import 'package:flutterexam/res/gaps.dart';
import 'package:flutterexam/widgets/app_bar.dart';
import 'package:flutterexam/common/global.dart';

class AnswerCardPage extends StatefulWidget {
  @override
  _AnswerCardPageState createState() => _AnswerCardPageState();
}

class _AnswerCardPageState extends State<AnswerCardPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '答题卡',
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30,top: 20,right: 30, bottom: 20),
            child: Row(
              children: <Widget>[
                Image.asset('assets/images/ic_back_black.png',width: 20, height: 20,),
                Text('当前题目'),
                Gaps.hGap32,
                Image.asset('assets/images/ic_back_black.png',width: 20, height: 20,),
                Text('已答'),
                Gaps.hGap32,
                Image.asset('assets/images/ic_back_black.png',width: 20, height: 20,),
                Text('未答'),
                Gaps.hGap32,
                Image.asset('assets/images/ic_back_black.png',width: 20, height: 20,),
                Text('标记疑问'),
              ],
            ),
          ),

          Expanded(
            child: GridView.count(
              crossAxisCount: 6,
              padding: EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 20),
              //水平子Widget之间间距
              crossAxisSpacing: 10.0,
              //垂直子Widget之间间距
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.0,
              children: getWidgetList(),
            ),
          ),
        ],
      ),
    );
  }

  List<String> getDataList() {
    List<String> list = [];
    for (int i = 0; i < 100; i++) {
      list.add(i.toString());
    }
    return list;
  }

  List<Widget> getWidgetList() {
    return Global.instance.allQuestions.map((item) => getItemContainer(item)).toList();
  }

  Widget getItemContainer(Map item) {
    return GestureDetector(
      onTap: (){
        print(item);
      },
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 1,
              right: 1,
              child: Container(
                width: 15,
                height: 10,
                color: Colors.red,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: item['isanswer'] == '0' ? Border.all(color: Color(0xFFE5E5E5),width: 1) : Border.all(color: Color(0xFFFFA200),width: 1)
              ),
              child: Text(
                item['snumber'].toString(),
                style: TextStyle(color: item['isanswer'] == '0' ? Color(0xFFE5E5E5) : Color(0xFFFFA200), fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
