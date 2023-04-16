import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:equalizer/equalizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class CustomEquilizer extends StatefulWidget {
  const CustomEquilizer({Key key}) : super(key: key);

  @override
  State<CustomEquilizer> createState() => _CustomEquilizerState();
}

class _CustomEquilizerState extends State<CustomEquilizer> {


  bool enableCustomEQ = false;

  @override
  void initState() {
    super.initState();
    Equalizer.init(0);
  }

  @override
  void dispose() {
    Equalizer.release();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title:  Text('Gravity'.toUpperCase(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [

          SizedBox(height: 10.0),
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
          SizedBox(height: 10.0),
          Container(
            color: Colors.white,
            child: SwitchListTile(
              activeColor: Colors.red,
              title: Text('Custom Equalizer'),
              value: enableCustomEQ,
              onChanged: (value) {
                Equalizer.setEnabled(value);
                setState(() {
                  enableCustomEQ = value;
                });
              },
            ),
          ),

          FutureBuilder<List<int>>(
            future: Equalizer.getBandLevelRange(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? CustomEQ(enableCustomEQ, snapshot.data)
                  : CircularProgressIndicator();
            },
          ),

        ],
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
            ? Column(
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
                  decoration: BoxDecoration(

                  ),
                  child: Material(
                    type: MaterialType.circle,
                    color: Colors.red,
                    elevation: 5,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.arrow_drop_up, size: 25,)),
                  ),
                ),
                rightHandler: FlutterSliderHandler(
                  child: Icon(Icons.chevron_left, color: Colors.red, size: 24,),
                ),
                handlerAnimation: FlutterSliderHandlerAnimation(
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.bounceIn,
                    duration: Duration(milliseconds: 500),
                    scale: 1.5
                ),
                trackBar: FlutterSliderTrackBar(
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 3, color: Colors.white),
                  ),
                  activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.red.withOpacity(0.5)
                  ),
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
        Text('${freq ~/ 1000} Hz',style: TextStyle(color:Colors.white),),
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