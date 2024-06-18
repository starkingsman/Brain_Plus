import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weichan_xiongchao/DAHANG/XWNLxinran/c/XWNLxiaodufangyiPage.dart';

class XWNLruangChanglanPage extends StatefulWidget {
  final int quebaojianlaiIndex;
  XWNLruangChanglanPage({required this.quebaojianlaiIndex});

  @override
  _XWNLruangChanglanPageState createState() => _XWNLruangChanglanPageState();
}
class _XWNLruangChanglanPageState extends State<XWNLruangChanglanPage> {
  bool huojixuanBool = false;

  List<bool> huitanshiSelectList = List.filled(10, false);
  String kengqiangliStr = "";

  Map<String, dynamic> luanshijiaItem = {"":""};

  void caizhangtunData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? gelihaiValue = prefs.getBool('siwei');
    if (gelihaiValue != null) {
      setState(() {
        huojixuanBool = gelihaiValue;
      });

    } else {
      setState(() {
        huojixuanBool = false;
      });
    }

    String zichuanStr = 'lib/DAHANG/XWNLxinran/M/jafsdkan.json';
    if (huojixuanBool == true) {
      zichuanStr = 'lib/DAHANG/XWNLxinran/M/kafud.json';
    }
    String jsonData = await rootBundle.loadString(zichuanStr);
    List<dynamic> quanshunzhaiyueList = jsonDecode(jsonData);
    setState(() {
      luanshijiaItem = quanshunzhaiyueList[widget.quebaojianlaiIndex];
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    caizhangtunData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true, //
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(width: 25, height: 25, 'zhangxin/liaoxin.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Text(
          huojixuanBool == true ? "游戏玩法二（困难）" : "游戏玩法二（简单）",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: Stack(
        children: [
          XWNLmangtai(),
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
                  SizedBox(height: 20),
                  XWNLchunshiman(luanshijiaItem["hedaoyi"] != null
                      ? luanshijiaItem["hedaoyi"][0]
                      : "",luanshijiaItem["hedaoyi"] != null
                      ? luanshijiaItem["hedaoyi"][1]
                      : "",luanshijiaItem["hedaoyi"] != null
                      ? luanshijiaItem["hedaoyi"][2]
                      : ""),
                  SizedBox(height: 15),
                  XWNLchunshiman(luanshijiaItem["erdaihuo"] != null
                      ? luanshijiaItem["erdaihuo"][0]
                      : "",luanshijiaItem["erdaihuo"] != null
                      ? luanshijiaItem["erdaihuo"][1]
                      : "",luanshijiaItem["erdaihuo"] != null
                      ? luanshijiaItem["erdaihuo"][2]
                      : ""),
                  SizedBox(height: 15),
                  XWNLchunshiman(luanshijiaItem["shantongdian"] != null
                      ? luanshijiaItem["shantongdian"][0]
                      : "",luanshijiaItem["shantongdian"] != null
                      ? luanshijiaItem["shantongdian"][1]
                      : "",luanshijiaItem["shantongdian"] != null
                      ? luanshijiaItem["shantongdian"][2]
                      : ""),
                  SizedBox(height: 10),
                  qianlaikanXWNL(),
                  SizedBox(height: 10),
                  huangmangshense(),
                  SizedBox(height: 10),
                  laomoshishang(),
                  SizedBox(height: 20),
                  zjamhqo()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget XWNLchunshiman(String zhaichaojinStr1,String zhaichaojinStr2,String zhaichaojinStr3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(151, 209, 115, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            textAlign: TextAlign.center,
            zhaichaojinStr1,
            style: TextStyle(
                color: zhaichaojinStr1 == '?' ? Colors.red : Color.fromRGBO(255, 255, 255, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          textAlign: TextAlign.center,
          "×",
          style: TextStyle(
              color: Color.fromRGBO(5, 5, 5, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(151, 209, 115, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            textAlign: TextAlign.center,
            zhaichaojinStr2,
            style: TextStyle(
                color: zhaichaojinStr2 == '?' ? Colors.red : Color.fromRGBO(255, 255, 255, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          textAlign: TextAlign.center,
          "=",
          style: TextStyle(
              color: Color.fromRGBO(5, 5, 5, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(151, 209, 115, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            textAlign: TextAlign.center,
            zhaichaojinStr3,
            style: TextStyle(
                color: zhaichaojinStr3 == '?' ? Colors.red : Color.fromRGBO(255, 255, 255, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }

  void huatanxun(BuildContext context) {
    if (widget.quebaojianlaiIndex > 0) {
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

  void liaomodao(BuildContext context) async {
    String zichuanStr = 'lib/DAHANG/XWNLxinran/M/jafsdkan.json';
    if (huojixuanBool == true) {
      zichuanStr = 'lib/DAHANG/XWNLxinran/M/kafud.json';
    }
    String jsonData = await rootBundle.loadString(zichuanStr);
    List<dynamic> quanshunzhaiyueList = jsonDecode(jsonData);

    if (widget.quebaojianlaiIndex < quanshunzhaiyueList.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => XWNLruangChanglanPage(quebaojianlaiIndex: widget.quebaojianlaiIndex + 1),
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

  void fengchanglaiTap(int index) {
    setState(() {
      huitanshiSelectList = List.filled(10, false);
      huitanshiSelectList[index] = true;
      kengqiangliStr =  '$index';
    });

    if(luanshijiaItem["dejieSelect"] == '$index') {
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

  }

  Widget XWNLmangtai() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'zhangxin/huixin.png',
        fit: BoxFit.fill,
      ),
    );
  }


  Widget laomoshishang() {
    final double itemSize = 60.0;
    final double spacing = 5.0;
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: List.generate(10, (index) {
        Color backgroundColor = huitanshiSelectList[index] ? Colors.red : Color.fromRGBO(151, 209, 115, 1);
        return GestureDetector(
          onTap: () => fengchanglaiTap(index),
          child: Container(
            width: itemSize,
            height: itemSize,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(25)
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

  Widget zjamhqo() {
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
      onTap:() => huatanxun(context),
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            color: Color.fromRGBO(112, 90, 34, 1),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Text(
          textAlign: TextAlign.center,
          "上一个",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget xingluanrenjian() {
    return GestureDetector(
      onTap:() => liaomodao(context),
      child: Container(
        width: 120,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color.fromRGBO(12, 220, 34, 1),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Text(
          textAlign: TextAlign.center,
          "下一个",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget huangmangshense() {
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

  Widget qianlaikanXWNL() {
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
            kengqiangliStr,
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


}
