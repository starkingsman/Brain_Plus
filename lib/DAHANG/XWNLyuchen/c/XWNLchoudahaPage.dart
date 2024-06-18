import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class XWNLchoudahaPage extends StatefulWidget {
  @override
  _XWNLchoudahaPageState createState() => _XWNLchoudahaPageState();
}
class _XWNLchoudahaPageState extends State<XWNLchoudahaPage> {
  bool huojixuanBool = false;

  Future<void> setDiqukuazhaxun(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('siwei', value); // 存储布尔值
  }

  Future<bool?> getDiqukuazhaxun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('siwei'); // 检索布尔值，如果键不存在则返回null
  }

  void cjamhdData() async {
    // 检索值
    bool? retrievedValue = await getDiqukuazhaxun();
    if (retrievedValue != null) {
      print('检索到的值: ${retrievedValue ? 'true' : 'false'}');
      setState(() {
        huojixuanBool = retrievedValue;
      });

    } else {
      print('没有找到键 "siwei"');
      await setDiqukuazhaxun(false);
      setState(() {
        huojixuanBool = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cjamhdData();
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
          "游戏难度",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: Stack(
        children: [
          chendaxiaogaimo(),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight + 30, left: 15, right: 15),
            height: 200,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: Color.fromRGBO(237, 252, 218, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  huojixuanBool == false ? xudaojianhuatong(0) : jielankanbian(0),
                  SizedBox(height: 10),
                  huojixuanBool == false ? jielankanbian(1): xudaojianhuatong(1) ,
                  SizedBox(height: 20),
                ],
              ),
          ),
          qiangbaochun(),
        ],
      ),
    );
  }

  Widget chendaxiaogaimo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'zhangxin/huixin.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget xudaojianhuatong(int jingluTag) {
    return GestureDetector(
      onTap:() => qianmoyan(context,jingluTag),
      child: Container(
        width: 200,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color.fromRGBO(12, 220, 34, 1),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Text(
          textAlign: TextAlign.center,
          jingluTag == 0 ? "简单" : "困难",
          style: TextStyle(
            color:  Color.fromRGBO(255, 255, 255, 1),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget jielankanbian(int jingluTag) {
    return GestureDetector(
      onTap:() => qianmoyan(context,jingluTag),
      child: Container(
        width: 200,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25)
        ),
        child: Text(
          textAlign: TextAlign.center,
          jingluTag == 0 ? "简单" : "困难",
          style: TextStyle(
            color:  Color.fromRGBO(5, 5, 5, 1),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
  Widget qiangbaochun() {
    return GestureDetector(
      onTap:() => xuzhao(context),
      child: Container(
        height: 50,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight + 300, left: 50, right: 50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color.fromRGBO(102, 120, 64, 1),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Text(
          textAlign: TextAlign.center,
          "保存",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  void qianmoyan(BuildContext context, int jingluTag) async {
    if(jingluTag == 0){
      await setDiqukuazhaxun(false);
      setState(() {
        huojixuanBool = false;
      });
    }else {
      await setDiqukuazhaxun(true);
      setState(() {
        huojixuanBool = true;
      });
    }
  }

  void xuzhao(BuildContext context) {
    Fluttertoast.showToast(
      msg: '保存成功，请再次查看游戏',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }
}
