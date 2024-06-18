import 'InitData.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class DataModel {
  static String setStr(String string) {
    String input = string;
    List<int> charCodes = input.runes.toList();
    String hexString = charCodes.map((code) => code.toRadixString(16)).join('');
    debugPrint("==  $hexString");
    return hexString;
  }

  static String getStr(String hexString) => List.generate(
        hexString.length ~/ 2,
        (i) => String.fromCharCode(
            int.parse(hexString.substring(i * 2, (i * 2) + 2), radix: 16)),
      ).join();

  static getData() async {
    var httpClient = HttpClient();
    String result = "";
    try {
      String str =
          "https://afbbbquv.api.lncldglobal.com/1.1/classes/Math88/66708bbd44b780747af2ad68";
      String appID = "aFbbbquVAS9QMzAG2cXV9cyK-MdYXbMMI";
      String appKey = "ipRK9dg8yNfD8qwd5jkPs7T2";

      var req = await httpClient.getUrl(Uri.parse(str));
      req.headers.add('Content-Type', 'application/json');
      req.headers.add('X-LC-Id', appID);
      req.headers.add('X-LC-Key', appKey);

      var repo = await req.close();
      if (repo.statusCode == HttpStatus.ok) {
        var json = await repo.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        int type;
        type = (data["login"] ?? 0) as int;
        String mKey = data["key"] as String;
        String? funName = data["fName"];
        String? eventName = data["eName"];

        InitData.login = (type == 0) ? false : true;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('key', mKey);
        await prefs.setString('fName', funName ?? "");
        await prefs.setString('eName', eventName ?? "");

        result = data.toString();
      } else {
        result = 'DataUtil error == s ${repo.statusCode}';
      }
    } catch (exception) {
      result = '== Failed : $exception';
    } finally {
      debugPrint("05 ==: $result");
      httpClient.close();
    }
  }
}
