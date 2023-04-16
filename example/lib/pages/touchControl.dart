import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:equalizer/equalizer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/constant.dart';


class TouchControlPage extends StatefulWidget {
  @override
  _TouchControlPageState createState() => _TouchControlPageState();
}

class _TouchControlPageState extends State<TouchControlPage> {
  final _loginFormKey = GlobalKey<FormState>();

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
                            "Touch Control",
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
                            "Modify or view touch control functions for your earbuds.",
                            style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHeightVeryBig,

                  Card(
                      color: Colors.white,
                      elevation: 8.0,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: _createDataTableForSingleTap(),
                  ),
                  kHeightVeryBig,
                  kHeightVeryBig,
                  Card(
                    color: Colors.white,
                    elevation: 8.0,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: _createDataTableForDoubleTap(),
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

                           {},

                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>TabPage()));

                        child: Text("Reset to Default",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
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
  DataTable _createDataTableForSingleTap() {
    return DataTable(
        columnSpacing: 150,
        columns: _createColumnsForSingleTap(),
        rows: _createRowsForSingleTap());
  }
  List<DataColumn> _createColumnsForSingleTap() {
    return [
      DataColumn(

          label: Text('Single Tap')
      ),
      DataColumn(
          label: Text('')
      ),

    ];
  }
  List<DataRow> _createRowsForSingleTap() {
    return [
      DataRow(cells: [
        DataCell(
            Text('Left')
        ),
        DataCell(
            Row(
              children: [
                Text('Volume - '),
                Icon(Icons.arrow_drop_down_sharp)
              ],
            )
        ),

      ]),
      DataRow(cells: [
        DataCell(Text('Right')),
        DataCell(
            Row(
              children: [
                Text('Volume + '),
                Icon(Icons.arrow_drop_down_sharp)
              ],
            )
        ),

      ])
    ];
  }


  ///for double tap
  DataTable _createDataTableForDoubleTap() {
    return DataTable(
        columnSpacing: 150,
        columns: _createColumnsForDoubleTap(),
        rows: _createRowsForDoubleTap());
  }
  List<DataColumn> _createColumnsForDoubleTap() {
    return [
      DataColumn(

          label: Text('Double Tap')
      ),
      DataColumn(
          label: Text('')
      ),

    ];
  }
  List<DataRow> _createRowsForDoubleTap() {
    return [
      DataRow(cells: [
        DataCell(
            Text('Left')
        ),
        DataCell(
            Row(
              children: [
                Text('Volume - '),
                Icon(Icons.arrow_drop_down_sharp)
              ],
            )
        ),

      ]),
      DataRow(cells: [
        DataCell(Text('Right')),
        DataCell(
            Row(
              children: [
                Text('Volume + '),
                Icon(Icons.arrow_drop_down_sharp)
              ],
            )
        ),

      ])
    ];
  }

}
