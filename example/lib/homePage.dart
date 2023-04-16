import 'dart:async';
import 'dart:developer';

import 'package:audio_wave/audio_wave.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equalizer/equalizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volume_control/volume_control.dart';

import 'helpers/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool enableCustomEQ = false;
  bool deviceConnected = false;
  String mode= 'Gravity Mode';

  Future getDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    log("verii"+prefs.getBool("emailVerified").toString());
    log(prefs.getBool("phoneVerified").toString());
    log(prefs.getInt("uid").toString());
    log(prefs.getString("photo"));
  }

  @override
  void initState() {
    super.initState();
    getDetails();
    Equalizer.init(0);
    initVolumeState();
  }
  

  //init volume_control plugin
  Future<void> initVolumeState() async {
    if (!mounted) return;

    //read the current volume
    _val = await VolumeControl.volume;
    setState(() {});
  }

  double _val = 0.5;
  Timer timer;

  @override
  void dispose() {
    Equalizer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbackgroundColor,
      appBar: AppBar(
        // title:  Text('Gravity'.toUpperCase(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        backgroundColor: appbackgroundColor,
        title: Text("BEAST 350",style: TextStyle (color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        leading: BackButton(
            color: Colors.black
        ),
        actions: <Widget>[
          CircleAvatar(
            child: Image.asset("assets/defaultUser.png"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Card(
              elevation: 8.0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              child: InkWell(
                focusColor: Colors.white,
                // onTap: goToPage,
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/3,
                  width: 150,
                  // color: Colors.blueGrey[700],
                  // color: Colors.white10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffeff3ff),
                        offset: Offset(-2, -2),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(

                    children: [
                      SizedBox(width: 80,),
                      Column(

                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset("assets/beast350.png"),

                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${deviceConnected == false ? 'Not Connected' : 'Connected'}",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${mode}",
                            style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(width: 20,),
                      /// volume control
                      Column(
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Slider(
                                activeColor: Colors.black,
                                inactiveColor: Colors.grey,
                                value: _val,
                                min: 0,
                                max: 1,
                                divisions: 100,
                                onChanged: (val) {
                                  _val = val;
                                  setState(() {});
                                  if (timer != null) {
                                    timer?.cancel();
                                  }

                                  //use timer for the smoother sliding
                                  timer = Timer(Duration(milliseconds: 200), () {
                                    VolumeControl.setVolume(val);
                                  });

                                  print("val:$val");
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),


/// part of equilizer
            // Center(
            //   child: Builder(
            //     builder: (context) {
            //       return ElevatedButton.icon(
            //         icon: Icon(Icons.equalizer,color: Colors.white,),
            //         label: Text('Open device equalizer'),
            //
            //         onPressed: () async {
            //           try {
            //             await Equalizer.open(0);
            //           } on PlatformException catch (e) {
            //             final snackBar = SnackBar(
            //               behavior: SnackBarBehavior.floating,
            //               content: Text('${e.message}\n${e.details}'),
            //             );
            //             // Scaffold.of(context).showSnackBar(snackBar);
            //           }
            //         },
            //       );
            //     },
            //   ),
            // ),
            // SizedBox(height: 10.0),

            SizedBox(
              height: 15,
            ),

            /// Equilizer
            // FutureBuilder<List<int>>(
            //   future: Equalizer.getBandLevelRange(),
            //   builder: (context, snapshot) {
            //     return snapshot.connectionState == ConnectionState.done
            //         ?
            //     // Text("")
            //     CustomEQ(enableCustomEQ, snapshot.data)
            //         : CircularProgressIndicator();
            //   },
            // ),

            ///Modes

            Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: ListView(

                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      _mainButtonEquiDesign(
                          'assets/Adjust.png', "Equilizer",
                          goToPage: () => OpenDialogModes(context)),
                      // SizedBox(width:15,),
                      _mainButtonDesign(
                          true, 'Classical',"assets/touch.png", "Others",
                          goToPage: () => '#'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      _mainButtonDesign(
                          true, 'Dance', 'assets/modes.png', "Touch Control",
                          goToPage: () => '#'),
                      // SizedBox(width:15,),
                      _modesButtonDesgin("assets/more.png", "Modes",
                          goToPage: () => '#'),
                    ],
                  ),


                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // Row(
                  //   children: [
                  //     SizedBox(width:15,),
                  //     _poButtonDesign(true,'Rock',Icons.rocket_launch,"Rock Mode",
                  //         goToPage: () =>'#'),
                  //     // SizedBox(width:15,),
                  //     _poButtonDesign(true,'Pop',Icons.propane_outlined,"Pop Mode",
                  //         goToPage: () => '#'),
                  //   ],
                  // ),
                ],
              ),
            ),

            ///Custom equilizer
            // Container(
            //   color: Colors.white,
            //   child: SwitchListTile(
            //     activeColor: Colors.red,
            //     title: Text('Custom Equalizer'),
            //     value: enableCustomEQ,
            //     onChanged: (value) {
            //       Equalizer.setEnabled(value);
            //       setState(() {
            //         enableCustomEQ = value;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      ),

    );
  }
  _mainButtonDesign(
      bool tapped, String value, String icon, String buttonString,
      {VoidCallback goToPage}) {
    return Card(
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.red,
        onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: MediaQuery.of(context).size.height/6,
          width: 140,
          // color: Colors.blueGrey[700],
          // color: Colors.white10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffeff3ff),
                offset: Offset(-2, -2),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                Image.asset(
                  icon,

                  color: Colors.black,
                ),

                Text(
                  buttonString,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _mainButtonModesDesign(
      bool tapped, String value, IconData icon, String buttonString,
      {VoidCallback goToPage}) {
    return Card(
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.red,
        // onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Equalizer.setPreset(value);
              value=='Normal'?mode='Gravity Mode':value=='Rock'?mode='Rock Mode':value=='Classical'?mode='Classical Mode':value=='Pop'?mode='Pop Mode':'Gravity Mode';
              log(mode.toString());
              final snackBar = SnackBar(
                duration: Duration(milliseconds: 500),
                content:  Text('You have switched to ${mode}'),
                // action: SnackBarAction(
                //   label: 'Undo',
                //   onPressed: () {
                //
                //   },
                // ),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);


            });

            Navigator.pop(context);
          },
          child: Container(
            height: MediaQuery.of(context).size.height/6,
            width: 140,
            // color: Colors.blueGrey[700],
            // color: Colors.white10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffeff3ff),
                  offset: Offset(-2, -2),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [

                  Icon(
                    icon,

                    color: Colors.black,
                  ),

                  Text(
                    buttonString,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _mainButtonEquiDesign(
       String icon, String buttonString,
      {VoidCallback goToPage}) {
    return Card(
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.red,
        onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: MediaQuery.of(context).size.height/6,
          width: 140,
          // color: Colors.blueGrey[700],
          // color: Colors.white10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffeff3ff),
                offset: Offset(-2, -2),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [

                Image.asset(
                  icon,

                  color: Colors.black,
                ),

                Text(
                  buttonString,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10,),
                AudioWave(
                  height: 32,
                  width: 120,
                  spacing: 5,
                  alignment: 'bottom',
                  // animationLoop: 2,
                  beatRate: Duration(milliseconds: 100),
                  bars: [
                    AudioWaveBar(heightFactor: 1, color: Colors.lightBlueAccent),
                    AudioWaveBar(heightFactor: 0.9, color: Colors.blue),
                    AudioWaveBar(heightFactor: 0.8, color: Colors.black),
                    AudioWaveBar(heightFactor: 0.7),
                    AudioWaveBar(heightFactor: 0.6, color: Colors.orange),
                    AudioWaveBar(heightFactor: 0.5, color: Colors.lightBlueAccent),

                    AudioWaveBar(heightFactor: 0.2),
                    AudioWaveBar(heightFactor: 0.1, color: Colors.orange),
                    AudioWaveBar(heightFactor: 1, color: Colors.lightBlueAccent),
                    AudioWaveBar(heightFactor: 0.1, color: Colors.blue),

                    AudioWaveBar(heightFactor: 0.4, color: Colors.orange),
                    AudioWaveBar(heightFactor: 0.5, color: Colors.lightBlueAccent),
                    AudioWaveBar(heightFactor: 0.6, color: Colors.blue),
                    AudioWaveBar(heightFactor: 0.7, color: Colors.black),
                    AudioWaveBar(heightFactor: 0.8),
                    AudioWaveBar(heightFactor: 0.9, color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future OpenDialogModes(BuildContext context) =>
      showDialog(
        barrierColor: Colors.black38,
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  // height:600,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Column(
                      children: [
                        kHeightVeryBig,
                        kHeightVeryBig,

                        Align(
                          alignment: Alignment.centerLeft,
                            child: Text("Equilizer",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Try out different sound modes pre-defined by Gravity.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),)
                        ),
                        kHeightVeryBig,
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _mainButtonModesDesign(
                                true, 'Normal', Icons.compare_arrows, "Gravity Tuned",
                                goToPage: () => '#'),
                            _mainButtonModesDesign(
                                true, 'Pop', Icons.format_strikethrough_sharp, "Bass Mode",
                                goToPage: () => '#'),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _mainButtonModesDesign(
                                true, 'Pop', Icons.vibration_outlined, "Treble Mode",
                                goToPage: () => '#'),
                            _mainButtonModesDesign(
                                true, 'Rock', Icons.rocket, "Rock Mode",
                                goToPage: () => '#'),

                          ],
                        ),
                        _mainButtonModesDesign(
                            true, 'Classical', Icons.mic, "Classic Mode",
                            goToPage: () => '#'),



                      ],
                    ),
                  ),

                ),
              ),
              Positioned(
                  top:-35,

                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Image.asset("assets/gravity.png"),
                    radius: 40,

                  )),


            ],
          ),
        ),

      );
  _modesButtonDesgin(String icon, String buttonString,
      {VoidCallback goToPage}) {
    return Card(
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        focusColor: Colors.red,
        onTap: goToPage,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: MediaQuery.of(context).size.height/6,
          width: 140,
          // color: Colors.blueGrey[700],
          // color: Colors.white10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffeff3ff),
                offset: Offset(-2, -2),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Image.asset(
                  icon,

                  color: Colors.black,
                ),
                Text(
                  buttonString,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}

class CustomEQ extends StatefulWidget {
  const CustomEQ(this.enabled, this.bandLevelRange);

  final bool enabled;
  final List<int> bandLevelRange;

  @override
  _CustomEQState createState() => _CustomEQState();
}

class _CustomEQState extends State<CustomEQ> {
  double min, max;
  String _selectedValue;
  Future<List<String>> fetchPresets;

  @override
  void initState() {
    super.initState();
    min = widget.bandLevelRange[0].toDouble();
    max = widget.bandLevelRange[1].toDouble();

    fetchPresets = Equalizer.getPresetNames();
  }

  @override
  Widget build(BuildContext context) {
    int bandId = 0;

    return FutureBuilder<List<int>>(
      future: Equalizer.getCenterBandFreqs(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? Container(
                // color: Colors.grey,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                    ),
                    color: Color(0xff021414)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data
                          .map((freq) => _buildSliderBand(freq, bandId++))
                          .toList(),
                    ),

                    Divider(),
                    // Padding(
                    //
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: _buildPresets(),
                    // ),
                  ],
                ),
              )
            : CircularProgressIndicator();
      },
    );
  }

  Widget _buildSliderBand(int freq, int bandId) {
    return Column(
      children: [
        SizedBox(
          height: 200.0,
          child: FutureBuilder<int>(
            future: Equalizer.getBandLevel(bandId),
            builder: (context, snapshot) {
              return FlutterSlider(
                handler: FlutterSliderHandler(
                  decoration: BoxDecoration(),
                  child: Material(
                    type: MaterialType.circle,
                    color: Color(0xff00FFFF),
                    elevation: 5,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 25,
                        )),
                  ),
                ),
                rightHandler: FlutterSliderHandler(
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                handlerAnimation: FlutterSliderHandlerAnimation(
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.bounceIn,
                    duration: Duration(milliseconds: 500),
                    scale: 1.5),
                trackBar: FlutterSliderTrackBar(
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 3, color: Colors.white),
                  ),
                  activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.red.withOpacity(0.5)),
                ),
                disabled: !widget.enabled,
                axis: Axis.vertical,
                rtl: true,
                min: min,
                max: max,
                values: [snapshot.hasData ? snapshot.data.toDouble() : 0],
                onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                  Equalizer.setBandLevel(bandId, lowerValue.toInt());
                },
              );
            },
          ),
        ),
        Text(
          '${freq ~/ 1000} Hz',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPresets() {
    return FutureBuilder<List<String>>(
      future: fetchPresets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final presets = snapshot.data;
          if (presets.isEmpty) return Text('No presets available!');
          return Container(
            color: Colors.white,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Available Presets',
                border: OutlineInputBorder(),
              ),
              value: _selectedValue,
              onChanged: widget.enabled
                  ? (String value) {
                      Equalizer.setPreset(value);
                      setState(() {
                        _selectedValue = value;
                        log(value.toString());
                      });
                    }
                  : null,
              items: presets.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          );
        } else if (snapshot.hasError)
          return Text(snapshot.error);
        else
          return CircularProgressIndicator();
      },
    );
  }
}
