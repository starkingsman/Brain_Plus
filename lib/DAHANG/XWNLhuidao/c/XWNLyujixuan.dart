import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weichan_xiongchao/DAHANG/XWNLxinran/c/XWNLxiaodufangyiPage.dart';
import 'package:weichan_xiongchao/DAHANG/XWNLxiongfu/c/XWNLruangChanglanPage.dart';
import 'package:weichan_xiongchao/DAHANG/XWNLyuchen/c/XWNLchoudahaPage.dart';

class XWNLyujixuanPage extends StatefulWidget {
  @override
  _XWNLyujixuanPageState createState() => _XWNLyujixuanPageState();
}
class _XWNLyujixuanPageState extends State<XWNLyujixuanPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chengjieData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Text(
          "",
        ),
      ),
      body: Stack(
        children: [
          XWNLhanxiqna(),
          Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight, left: 20, right: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    XWNLxiangyanhai(),
                    SizedBox(height: 20),
                    XWNLkuanwang(0),
                    SizedBox(height: 20),
                    XWNLkuanwang(1),
                    SizedBox(height: 20),
                    XWNLkuanwang(2),
                  ],
                ),
              ),

          )
        ],
      ),
    );
  }


  Widget XWNLkuanwang(int dingzhiTag) {
    return GestureDetector(
        onTap: () {
          guizhengqu(context,dingzhiTag);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromRGBO(237, 252, 218, 1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                width: 100,
                height: 100,
                dingzhiTag == 2 ? 'zhangxin/xinhao.png' : "zhangxin/hendian.png",
                fit: BoxFit.fill,
              ),
              SizedBox(width: 10),
              Text(
                textAlign: TextAlign.center,
                dingzhiTag == 0 ? "游戏（玩法一）": dingzhiTag == 1 ? "游戏（玩法二）" : "游戏难度",
                style: TextStyle(
                  color: Color.fromRGBO(5, 5, 5, 1),
                  fontSize: 22,
                ),
              ),
            ],
          ),
        )
    );
  }

  void guizhengqu(BuildContext, duoTag) {
    if (duoTag == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => XWNLxiaodufangyiPage(xuanzeyemaIndex: 0)));
    }else if (duoTag == 1) {

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => XWNLruangChanglanPage(quebaojianlaiIndex: 0)));
    }else {

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => XWNLchoudahaPage()));
    }

  }

  Widget XWNLhanxiqna() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'zhangxin/huixin.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget XWNLxiangyanhai() {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        textAlign: TextAlign.center,
        "思维小游戏",
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontSize: 30,
        ),
      ),
    );
  }

  void chengjieData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? retrievedValue = prefs.getBool('siwei');
    if (retrievedValue == null) {
      prefs.setBool('siwei', false);
    }
  }

}
