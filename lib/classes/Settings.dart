import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting  {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

   static String _ip="127.0.0.1";

   Future<bool> saveMyIP(String ip) async
   {
     SharedPreferences prefs= await SharedPreferences.getInstance();
     prefs.setString("myip", ip);
     print("Save ip :"+ip);
     return prefs.commit();
   }

  Future<String> loadMyIP() async
  {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String ip=prefs.getString("myip");
    print("Load ip :"+ip);
    return ip;
  }

   static String getServerIP()
  {
    return _ip;
  }
  static void setServerIP(ip)
  {
    _ip=ip;
  }

}
