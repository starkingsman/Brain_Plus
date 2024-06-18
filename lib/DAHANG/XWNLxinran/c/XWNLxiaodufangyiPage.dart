import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class XWNLxiaodufangyiPage extends StatefulWidget {
  final int xuanzeyemaIndex;
  XWNLxiaodufangyiPage({required this.xuanzeyemaIndex});

  @override
  _XWNLxiaodufangyiPageState createState() => _XWNLxiaodufangyiPageState();
}
class _XWNLxiaodufangyiPageState extends State<XWNLxiaodufangyiPage> {
  bool qiajiacaorenBool = false;

  List<bool> isSelected = List.filled(10, false);
  String xuandeshunStr = "";

  Map<String, dynamic> zhenjianzongObj = {"":""};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true, //
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(width: 30, height: 30, 'zhangxin/liaoxin.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Text(
          qiajiacaorenBool == true ? "游戏玩法一（困难）" : "游戏玩法一（简单）",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: Stack(
        children: [
          kangxielanXWNL(),
          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight, left: 15, right: 15),
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top -
                  10,
              decoration: BoxDecoration(
                color: Color.fromRGBO(237, 252, 218, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    XWNLxujielai(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        xuzhengtiaojie(zhenjianzongObj["hedaoyi"] != null
                            ? zhenjianzongObj["hedaoyi"][0]
                            : "",zhenjianzongObj["hedaoyi"] != null
                            ? zhenjianzongObj["hedaoyi"][1]
                            : "",zhenjianzongObj["hedaoyi"] != null
                            ? zhenjianzongObj["hedaoyi"][2]
                            : ""),
                        SizedBox(width: 15),
                        xuzhengtiaojie(zhenjianzongObj["erdaihuo"] != null
                            ? zhenjianzongObj["erdaihuo"][0]
                            : "",zhenjianzongObj["erdaihuo"] != null
                            ? zhenjianzongObj["erdaihuo"][1]
                            : "",zhenjianzongObj["erdaihuo"] != null
                            ? zhenjianzongObj["erdaihuo"][2]
                            : ""),
                      ],
                    ),
                    xuzhengtiaojie(zhenjianzongObj["shantongdian"] != null
                        ? zhenjianzongObj["shantongdian"][0]
                        : "",zhenjianzongObj["shantongdian"] != null
                        ? zhenjianzongObj["shantongdian"][1]
                        : "",zhenjianzongObj["shantongdian"] != null
                        ? zhenjianzongObj["shantongdian"][2]
                        : ""),
                    SizedBox(height: 10),
                    ganghaoXWNLtai(),
                    SizedBox(height: 10),
                    jiaodinbankan(),
                    SizedBox(height: 10),
                    xunchangdeng()
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget kangxielanXWNL() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'zhangxin/huixin.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget XWNLxujielai() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        textAlign: TextAlign.center,
        "计算问号的值，选择下方正确的数字并点击",
        style: TextStyle(
          color: Color.fromRGBO(55, 55, 55, 1),
          fontSize: 12,
        ),
      ),
    );
  }

  Widget xuzhengtiaojie(String shunziStr1,String shunziStr2,String shunziStr3) {
    return Stack(
        children: [
          Container(
            width: 150,
            height: 150,
            child: Image.asset(
              'zhangxin/xiaobing.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: 150,
            height: 150,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 75,
                      height: 30,
                      margin: EdgeInsets.only(top: 40),
                      alignment: Alignment.center,
                      child: Text(
                        textAlign: TextAlign.center,
                        shunziStr1,
                        style: TextStyle(
                            color: shunziStr1 == '?' ? Colors.red : Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      width: 75,
                      height: 30,
                      margin: EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        textAlign: TextAlign.center,
                        shunziStr2,
                        style: TextStyle(
                            color: shunziStr2 == '?' ? Colors.red : Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                  ],
                ),
                Container(
                  width: 80,
                  height: 30,
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    shunziStr3,
                    style: TextStyle(
                      color: shunziStr3 == '?' ? Colors.red : Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            )
          )
        ],
    );
  }

  Widget ganghaoXWNLtai() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 75,
          height: 40,
          child: Image.asset(
            'zhangxin/huachui.png',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 100,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(241, 242, 240, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            textAlign: TextAlign.center,
            xuandeshunStr,
            style: TextStyle(
                color: Color.fromRGBO(55, 55, 55, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }

  Widget jiaodinbankan() {
    final double itemSize = 50.0;
    final double spacing = 5.0;
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: List.generate(10, (index) {
        Color backgroundColor = isSelected[index] ? Colors.red : Colors.green;
        return GestureDetector(
          onTap: () => handleNumberTap(index),
          child: Container(
            width: itemSize,
            height: itemSize,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: Colors.black, width: 1.0),
            ),
            child: Center(
              child: Text(
                '${index}',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget xunchangdeng() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        xingzuochengxun(),
        SizedBox(width: 5),
        xingluanrenjian(),
      ],
    );
  }

  Widget xingzuochengxun() {
    return GestureDetector(
      onTap:() => zuohaokanlan(context),
      child: Container(
        width: 120,
        height: 40,
        child: Image.asset(
          'zhangxin/zuoxu.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget xingluanrenjian() {
    return GestureDetector(
      onTap:() => jingxuanpin(context),
      child: Container(
        width: 120,
        height: 40,
        child: Image.asset(
          'zhangxin/chaoxianglai.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  void zuohaokanlan(BuildContext context) {
    if (widget.xuanzeyemaIndex > 0) {
      Navigator.of(context).pop();

    } else {
      Fluttertoast.showToast(
        msg: '当前已经是第一个了',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void jingxuanpin(BuildContext context) async {
    String zichuanStr = 'lib/DAHANG/XWNLxinran/M/huazhiganlai.json';
    if (qiajiacaorenBool == true) {
      zichuanStr = 'lib/DAHANG/XWNLxinran/M/ianglafn.json';
    }
    String jsonData = await rootBundle.loadString(zichuanStr);
    List<dynamic> quanshunzhaiyueList = jsonDecode(jsonData);

    if (widget.xuanzeyemaIndex < quanshunzhaiyueList.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => XWNLxiaodufangyiPage(xuanzeyemaIndex: widget.xuanzeyemaIndex + 1),
        ),
      );

    } else {
      Fluttertoast.showToast(
        msg: '已经到最后一个了',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void handleNumberTap(int index) {
    setState(() {
      isSelected = List.filled(10, false);
      // 设置被点击数字的选中状态为true
      isSelected[index] = true;
      xuandeshunStr =  '$index';
    });

    if(zhenjianzongObj["dejieSelect"] == '$index') {
      Fluttertoast.showToast(
        msg: '正确',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.white,
        textColor: Colors.green,
        fontSize: 16.0,
      );
    }else {
      Fluttertoast.showToast(
        msg: '错误',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 16.0,
      );
    }


    // 打印被点击的数字
    print('Number $index was tapped!');

  }

  void zhenggengadpingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? gelihaiValue = prefs.getBool('siwei');
    if (gelihaiValue != null) {
      setState(() {
        qiajiacaorenBool = gelihaiValue;
      });

    } else {
      setState(() {
        qiajiacaorenBool = false;
      });
    }

    String zichuanStr = 'lib/DAHANG/XWNLxinran/M/huazhiganlai.json';
    if (qiajiacaorenBool == true) {
      zichuanStr = 'lib/DAHANG/XWNLxinran/M/ianglafn.json';
    }
    String jsonData = await rootBundle.loadString(zichuanStr);

    List<dynamic> quanshunzhaiyueList = jsonDecode(jsonData);
    setState(() {
      zhenjianzongObj = quanshunzhaiyueList[widget.xuanzeyemaIndex];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    zhenggengadpingData();
  }


}
