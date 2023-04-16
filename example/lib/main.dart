import 'dart:async';
import 'dart:developer';
import 'package:after_layout/after_layout.dart';
import 'package:equalizer_example/bottmNavBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login/loginScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckUserLogin()
    );
  }
}


class CheckUserLogin extends StatefulWidget {
  @override
  _CheckUserLoginState createState() => _CheckUserLoginState();
}

class _CheckUserLoginState extends State<CheckUserLogin>
    with AfterLayoutMixin<CheckUserLogin>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/gravity.png'), fit: BoxFit.none),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
  bool _loggedIn =false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List token = [];
  token.add(prefs.getString("access_token"));
  log(token.toString());
  if(token[0]==null){
    setState(() {
      _loggedIn = false;
    });
  }else{
    setState(() {
      _loggedIn = true;
    });
  }
      if (_loggedIn==false) {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TabPage()));
      }
    }
  }



