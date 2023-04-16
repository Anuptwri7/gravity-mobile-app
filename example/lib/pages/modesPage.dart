import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:equalizer/equalizer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/constant.dart';
import '../helpers/stringConstant.dart';


class ModesPage extends StatefulWidget {
  @override
  _ModesPageState createState() => _ModesPageState();
}

class _ModesPageState extends State<ModesPage> {


  final _loginFormKey = GlobalKey<FormState>();


  bool _valueGravity = false;
  bool _valueBass = false;
  bool _valueTreble = false;
  bool _valueRock = false;
  bool _valueClassical = false;
  String valueModes='';
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return SafeArea(
      child: Scaffold(
        backgroundColor: appbackgroundColor,
        body: SizedBox(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/gravity.png",height: 80,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Equalizer",
                            style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // kHeightVeryBig,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Try out different sound modes pre-defined by Gravity.",
                            style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHeightVeryBig,
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    //   borderRadius: BorderRadius.circular(20),
                    // ), //BoxDecoration

                    /** CheckboxListTile Widget **/
                    child: CheckboxListTile(
                      title:  Text('Gravity Tuned [Balanced]'),
                      // subtitle: const Text('A computer science portal for geeks.'),
                      secondary: const Icon(Icons.music_video),
                      autofocus: false,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      selected: _valueGravity,
                      value: _valueGravity,
                      onChanged: (bool value) {
                        setState(() {
                          _valueGravity = value;
                          log(_valueGravity.toString());
                          _valueGravity == true?valueModes="Normal":valueModes="";
                          _valueBass = false;
                          _valueTreble =false;
                          _valueRock =false;
                          _valueClassical =false;
                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                        });
                      },
                    ), //CheckboxListTile
                  ),
                  SizedBox(height: 10,),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    //   borderRadius: BorderRadius.circular(20),
                    // ), //BoxDecoration

                    /** CheckboxListTile Widget **/
                    child: CheckboxListTile(
                      title:  Text('Bass Mode'),
                      // subtitle: const Text('A computer science portal for geeks.'),
                      secondary: const Icon(Icons.music_video),
                      autofocus: false,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      selected: _valueBass,
                      value: _valueBass,
                      onChanged: (bool value) {
                          setState(() {
                            _valueBass = value;
                            log(_valueBass.toString());
                            _valueBass == true?valueModes="Flat":valueModes="";
                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            _valueGravity = false;
                            _valueTreble =false;
                            _valueRock =false;
                            _valueClassical =false;
                          });
                      },
                    ), //CheckboxListTile
                  ),
                  SizedBox(height: 10,),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    //   borderRadius: BorderRadius.circular(20),
                    // ), //BoxDecoration

                    /** CheckboxListTile Widget **/
                    child: CheckboxListTile(
                      title:  Text('Treble Mode'),
                      // subtitle: const Text('A computer science portal for geeks.'),
                      secondary: const Icon(Icons.music_video),
                      autofocus: false,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      selected: _valueTreble,
                      value: _valueTreble,
                      onChanged: (bool value) {
                        setState(() {
                          _valueTreble = value;
                          log(_valueTreble.toString());
                          _valueTreble == true?valueModes="Heavy Metal":valueModes="";
                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          _valueGravity = false;
                          _valueBass =false;
                          _valueRock =false;
                          _valueClassical =false;
                        });
                      },
                    ), //CheckboxListTile
                  ),
                  SizedBox(height: 10,),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    //   borderRadius: BorderRadius.circular(20),
                    // ), //BoxDecoration

                    /** CheckboxListTile Widget **/
                    child: CheckboxListTile(
                      title:  Text('Rock Mode'),
                      // subtitle: const Text('A computer science portal for geeks.'),
                      secondary: const Icon(Icons.music_video),
                      autofocus: false,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      selected: _valueRock,
                      value: _valueRock,
                      onChanged: (bool value) {
                        setState(() {
                          _valueRock = value;
                          log(_valueRock.toString());
                          _valueRock == true?valueModes="Rock":valueModes="";



                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          _valueGravity = false;
                          _valueBass =false;
                          _valueTreble =false;
                          _valueClassical =false;

                        });
                      },
                    ), //CheckboxListTile
                  ),
                  SizedBox(height: 10,),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    //   borderRadius: BorderRadius.circular(20),
                    // ), //BoxDecoration

                    /** CheckboxListTile Widget **/
                    child: CheckboxListTile(
                      title:  Text('Classical Mode'),
                      // subtitle: const Text('A computer science portal for geeks.'),
                      secondary: const Icon(Icons.music_video),
                      autofocus: false,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      selected: _valueClassical,
                      value: _valueClassical,
                      onChanged: (bool value) {
                        setState(() {
                          _valueClassical = value;
                          log(_valueClassical.toString());
                          _valueClassical == true?valueModes="Classical":valueModes="";
                          _valueGravity = false;
                          _valueBass =false;
                          _valueRock =false;
                          _valueRock =false;

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.

                        });
                      },
                    ), //CheckboxListTile
                  ),
                  SizedBox(height: 50,),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2,

                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 2.0,
                            color: Color(0xff00FFFF),
                          ),
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ) ,
                          primary: appbackgroundColor,
                        ),

                        onPressed: ()=>

                             selectMode(valueModes),

                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>TabPage()));

                        child: Text("Done",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
                    ),
                  ),
                ],
              ), //Container
            ), //Padding
          ), //Center
        ),
      ),
    );

  }
  selectMode(String modes){
    Equalizer.setPreset(modes);
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 600),
      content:  Text('You have switched to ${modes} Mode'),

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
